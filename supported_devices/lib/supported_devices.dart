import 'package:supported_devices_platform_interface/supported_devices_platform_interface.dart';

class SupportedDevices extends SupportedDevicesPlatform {
  @override
  Future<String?> getRandomSupportedDevice() =>
      SupportedDevicesPlatform.instance.getRandomSupportedDevice();

  @override
  Future<void> toggleStreamingSupportedDevices(bool start) =>
      SupportedDevicesPlatform.instance.toggleStreamingSupportedDevices(start);

  @override
  Stream<String> supportedDevicesStream() =>
      SupportedDevicesPlatform.instance.supportedDevicesStream();
}
