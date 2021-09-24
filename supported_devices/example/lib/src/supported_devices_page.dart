import 'package:flutter/material.dart';
import 'package:supported_devices/supported_devices.dart';
import 'package:supported_devices_example/src/devices_stream_widget.dart';
import 'package:supported_devices_example/src/random_device_widget.dart';

class SupportedDevicesPage extends StatefulWidget {
  const SupportedDevicesPage({Key? key}) : super(key: key);

  @override
  State<SupportedDevicesPage> createState() => _SupportedDevicesPageState();
}

class _SupportedDevicesPageState extends State<SupportedDevicesPage> {
  final _supportedDevices = SupportedDevices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supported Devices Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RandomDeviceWidget(
              supportedDevices: _supportedDevices,
            ),
            const SizedBox(height: 100),
            DevicesStreamWidget(
              supportedDevices: _supportedDevices,
            ),
          ],
        ),
      ),
    );
  }
}
