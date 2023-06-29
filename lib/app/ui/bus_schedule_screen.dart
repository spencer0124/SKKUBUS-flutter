import 'package:flutter/material.dart';

class BusScheduleScreen extends StatefulWidget {
  const BusScheduleScreen({super.key});

  @override
  State<BusScheduleScreen> createState() => _BusScheduleScreenState();
}

class _BusScheduleScreenState extends State<BusScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('bus_schedule_screen'),
    );
  }
}
