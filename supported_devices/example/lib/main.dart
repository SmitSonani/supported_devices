import 'package:flutter/material.dart';
import 'package:supported_devices_example/src/supported_devices_page.dart';

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
      home: const SupportedDevicesPage(),
    );
  }
}
