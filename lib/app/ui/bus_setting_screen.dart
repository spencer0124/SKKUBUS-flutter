import 'package:flutter/material.dart';

class BusSettingScreen extends StatefulWidget {
  const BusSettingScreen({super.key});

  @override
  State<BusSettingScreen> createState() => _BusSettingScreenState();
}

class _BusSettingScreenState extends State<BusSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('bus_setting_screen'),
    );
  }
}
