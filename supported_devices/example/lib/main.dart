import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supported Devices Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _SupportedDevicesPage(),
    );
  }
}

class _SupportedDevicesPage extends StatelessWidget {
  const _SupportedDevicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supported Devices Example'),
      ),
    );
  }
}
