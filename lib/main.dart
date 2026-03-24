import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dhikr_app/screens/dikhr_screen.dart';

void main() {
  runApp(const ProviderScope(child: DhikrApp()));
}

class DhikrApp extends StatelessWidget {
  const DhikrApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dhikr App',
      theme: ThemeData(brightness: Brightness.dark),
      home: const DhikrScreen(),
    );
  }
}
