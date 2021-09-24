import Cocoa
import FlutterMacOS

public class SupportedDevicesMacosPlugin: NSObject {
    private static let instance = SupportedDevicesMacosPlugin()
    private let dataSource = DevicesDataSource()
    private var events: FlutterEventSink?
    private var timer: Timer?
    
    
}


extension SupportedDevicesMacosPlugin: FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "supported_devices",
                                                 binaryMessenger: registrar.messenger)
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        
        let eventChannel = FlutterEventChannel(name: "supported_devices/events",
                                               binaryMessenger: registrar.messenger)
        eventChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getRandom":
            result(dataSource.getRandomDevice())
        case "toggleStreaming":
            toggleStreaming(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func toggleStreaming(_ call: FlutterMethodCall,
                                 result: @escaping FlutterResult) {
        defer {
            result(nil)
        }
        guard let startStreaming = call.arguments as? Bool else {
            return
        }
        if !startStreaming {
            timer?.invalidate()
            return
        }
        if (timer?.isValid ?? false) {
            // Timer is already running. No action needed!
            return
        }
        
        // Emit 1st event immediately
        emitDeviceName(dataSource.getRandomDevice())
        
        // Scheduled timer for emitting sub-sequent events
        timer = Timer.scheduledTimer(withTimeInterval: 3.0,
                                     repeats: true) { [weak self] _ in
            guard let self = self else {
                return
            }
            self.emitDeviceName(self.dataSource.getRandomDevice())
        }
    }
    
    private func emitDeviceName(_ name: String) {
        if let events = events {
            let event = [
                "name": "supportedDevice",
                "data": name
            ]
            events(event)
        }
    }
    
}

// MARK: - FlutterStreamHandler
extension SupportedDevicesMacosPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?,
                         eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SupportedDevicesMacosPlugin.instance.events = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        SupportedDevicesMacosPlugin.instance.events = nil
        return nil
    }
}
