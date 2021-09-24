import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supported_devices/supported_devices.dart';

class DevicesStreamWidget extends StatefulWidget {
  const DevicesStreamWidget({
    Key? key,
    required this.supportedDevices,
  }) : super(key: key);

  final SupportedDevices supportedDevices;

  @override
  _DevicesStreamWidgetState createState() => _DevicesStreamWidgetState();
}

class _DevicesStreamWidgetState extends State<DevicesStreamWidget> {
  String? _currentDevice;
  StreamSubscription? _streamSubscription;
  bool _isStreaming = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => _listenForDevices(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            setState(() => _isStreaming = !_isStreaming);
            await widget.supportedDevices
                .toggleStreamingSupportedDevices(_isStreaming);
          },
          child: Text(
            _isStreaming ? 'Stop streaming' : 'Start streaming',
          ),
        ),
        const SizedBox(height: 30),
        if (_currentDevice != null) Text(_currentDevice!)
      ],
    );
  }

  void _listenForDevices() {
    _streamSubscription =
        widget.supportedDevices.supportedDevicesStream().listen(
      (device) {
        setState(() => _currentDevice = device);
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    widget.supportedDevices.toggleStreamingSupportedDevices(false);
    super.dispose();
  }
}
