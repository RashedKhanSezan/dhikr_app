import 'package:flutter/material.dart';

class DhikrModel {
  final int count;
  final String phrase;
  final Color bgColor;
  final Color accentColor;

  DhikrModel({
    required this.count,
    required this.phrase,
    required this.bgColor,
    required this.accentColor,
  });

  factory DhikrModel.initial() {
    return DhikrModel(
      count: 0,
      phrase: "SubhanAllah",
      bgColor: const Color(0xFF004D40),
      accentColor: const Color(0xFF64FFDA),
    );
  }
}