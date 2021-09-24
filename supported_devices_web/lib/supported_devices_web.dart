import 'dart:async';
import 'dart:math';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:supported_devices_platform_interface/supported_devices_platform_interface.dart';

class SupportedDevicesPlugin extends SupportedDevicesPlatform {
  /// Registers this class as the default instance of [SupportedDevicesPlatform].
  static void registerWith(Registrar registrar) {
    SupportedDevicesPlatform.instance = SupportedDevicesPlugin();
  }

  final devices = [
    'Firefox',
    'Google Chrome',
    'Microsoft Edge',
    'Apple Safari',
    'Opera',
    'Brave',
    'Vivaldi',
    'DuckDuckgo',
    'Netscape',
  ];
  final random = Random();
  Timer? timer;
  final streamController = StreamController<String>();

  @override
  Future<String?> getRandomSupportedDevice() async => _getRandomDevice();

  @override
  Future<void> toggleStreamingSupportedDevices(bool start) async {
    if (!start) {
      timer?.cancel();
    } else {
      // Emit 1st event immediately
      _emitRandomDevice();

      // Emit subsequent events periodically
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => _emitRandomDevice(),
      );
    }
  }

  @override
  Stream<String> supportedDevicesStream() =>
      streamController.stream.asBroadcastStream();

  String _getRandomDevice() {
    final pos = random.nextInt(devices.length);
    return devices[pos];
  }

  void _emitRandomDevice() {
    final device = _getRandomDevice();
    streamController.sink.add(device);
  }
}
