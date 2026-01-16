import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LastMileApp());
}

class LastMileApp extends StatelessWidget {
  const LastMileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastMile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
