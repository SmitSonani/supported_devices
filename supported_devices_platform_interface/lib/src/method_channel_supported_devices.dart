import 'package:flutter/services.dart';

import 'supported_devices_platform_interface.dart';

class MethodChannelSupportedDevices extends SupportedDevicesPlatform {
  final _methodChannel = const MethodChannel('supported_devices');
  final _eventChannel = const EventChannel('supported_devices/events');

  @override
  Future<String?> getRandomSupportedDevice() =>
      _methodChannel.invokeMethod<String>('getRandom');

  @override
  Future<void> toggleStreamingSupportedDevices(bool start) =>
      _methodChannel.invokeMethod<void>('toggleStreaming', start);

  @override
  Stream<String> supportedDevicesStream() => _eventChannel
      .receiveBroadcastStream()
      .map(_mapEvent)
      .where((event) => event != null)
      .map((event) => event!);

  String? _mapEvent(dynamic event) {
    final eventName = event['name'] as String;
    if (eventName == 'supportedDevice') {
      final device = event['data'] as String;
      return device;
    }
  }
}
