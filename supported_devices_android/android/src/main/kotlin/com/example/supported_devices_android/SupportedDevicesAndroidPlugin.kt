package com.example.supported_devices_android

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Timer
import kotlin.concurrent.fixedRateTimer

/** SupportedDevicesAndroidPlugin */
class SupportedDevicesAndroidPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel : MethodChannel
  private lateinit var eventChannel : EventChannel
  private var events: EventChannel.EventSink? = null
  private val dataSource = DevicesDataSource()
  private var timer: Timer? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "supported_devices")
    methodChannel.setMethodCallHandler(this)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "supported_devices/events")
    eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
      override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        events = eventSink
      }

      override fun onCancel(arguments: Any?) {
        events = null
      }
    })
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "getRandom" -> {
          result.success(dataSource.getRandomDevice())
        }
        "toggleStreaming" -> {
          toggleStreaming(call, result)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
    discardTimer()
  }

  private fun toggleStreaming(@NonNull call: MethodCall, @NonNull result: Result) {
    val startStreaming = call.arguments as? Boolean
    if (startStreaming == null) {
      result.success(null)
      return
    }

    if (!startStreaming) {
      discardTimer()
      result.success(null)
      return
    }

    discardTimer()

    timer = fixedRateTimer(name = "devices-emitter", initialDelay = 0, period = 3000) {
      Handler(Looper.getMainLooper()).post {
        emitDeviceName(dataSource.getRandomDevice())
      }
    }
  }

  private fun discardTimer() {
    timer?.cancel()
    timer = null
  }

  private fun emitDeviceName(device: String) {
    val event = mapOf("name" to "supportedDevice", "data" to device)
    events?.success(event)
  }
}
