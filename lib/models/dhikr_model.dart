import 'package:flutter/material.dart';

class DhikrModel {
  final int count;
  final int totalSubhanAllah;
  final int totalAlhamdulillah;
  final int totalAllahuAkbar;
  final int sessionsCompleted;
  final String phrase;
  final String arabicText;
  final String translation;
  final Color bgColor;
  final Color accentColor;
  final bool isSoundOn;
  final bool isVibrationOn;
  final bool isAutoSession;

  DhikrModel({
    required this.count,
    required this.totalSubhanAllah,
    required this.totalAlhamdulillah,
    required this.totalAllahuAkbar,
    required this.sessionsCompleted,
    required this.phrase,
    required this.arabicText,
    required this.translation,
    required this.bgColor,
    required this.accentColor,
    required this.isSoundOn,
    required this.isVibrationOn,
    required this.isAutoSession,
  });

  factory DhikrModel.initial() {
    return DhikrModel(
      count: 0,
      totalSubhanAllah: 0,
      totalAlhamdulillah: 0,
      totalAllahuAkbar: 0,
      sessionsCompleted: 0,
      phrase: "SubhanAllah",
      arabicText: "سبحان الله",
      translation: "Glory be to Allah",
      bgColor: const Color.fromARGB(225, 0, 77, 64),
      accentColor: const Color.fromARGB(164, 100, 255, 219),
      isSoundOn: true,
      isVibrationOn: true,
      isAutoSession: false,
    );
  }
}
