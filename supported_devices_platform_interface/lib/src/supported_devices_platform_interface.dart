import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_supported_devices.dart';

abstract class SupportedDevicesPlatform extends PlatformInterface {
  static SupportedDevicesPlatform _instance = MethodChannelSupportedDevices();

  static final _token = Object();

  static SupportedDevicesPlatform get instance => _instance;

  static set instance(SupportedDevicesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  SupportedDevicesPlatform() : super(token: _token);

  Future<String?> getRandomSupportedDevice() {
    throw UnimplementedError(
      'getRandomSupportedDevice() has not been implemented.',
    );
  }

  Future<void> toggleStreamingSupportedDevices(bool start) {
    throw UnimplementedError(
      'toggleStreamingSupportedDevices() has not been implemented.',
    );
  }

  Stream<String> supportedDevicesStream() {
    throw UnimplementedError(
      'supportedDevicesStream() has not been implemented.',
    );
  }
}
