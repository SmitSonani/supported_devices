import 'package:flutter/material.dart';
import 'package:supported_devices/supported_devices.dart';

class RandomDeviceWidget extends StatefulWidget {
  const RandomDeviceWidget({
    Key? key,
    required this.supportedDevices,
  }) : super(key: key);

  final SupportedDevices supportedDevices;

  @override
  State<RandomDeviceWidget> createState() => _RandomDeviceWidgetState();
}

class _RandomDeviceWidgetState extends State<RandomDeviceWidget> {
  String? _currentDevice;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => _getDevice(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _getDevice,
          child: const Text('Get Device'),
        ),
        const SizedBox(height: 30),
        if (_currentDevice != null) Text(_currentDevice!),
      ],
    );
  }

  Future<void> _getDevice() async {
    final device = await widget.supportedDevices.getRandomSupportedDevice();
    setState(() => _currentDevice = device);
  }
}
