// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/club_screen.dart';

void main() => runApp(const PadelBookingApp());

class PadelBookingApp extends StatelessWidget {
  const PadelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padel Booking',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ClubsScreen(),
    );
  }
}