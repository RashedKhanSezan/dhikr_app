import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/dhikr_model.dart';

class DhikrNotifier extends StateNotifier<DhikrModel> {
  DhikrNotifier() : super(DhikrModel.initial());

  final AudioPlayer _audioPlayer = AudioPlayer();

  void increment() async {
    final bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 50);
    }

    int nextCount = state.count + 1;

    if (nextCount >= 33) {
      _playCompletionSound();
      _transitionPhase();
    } else {
      state = DhikrModel(
        count: nextCount,
        phrase: state.phrase,
        bgColor: state.bgColor,
        accentColor: state.accentColor,
      );
    }
  }

  void _transitionPhase() {
    if (state.phrase == "SubhanAllah") {
      state = DhikrModel(
        count: 0,
        phrase: "Alhamdulillah",
        bgColor: const Color(0xFF1A237E),
        accentColor: Colors.lightBlueAccent,
      );
    } else if (state.phrase == "Alhamdulillah") {
      state = DhikrModel(
        count: 0,
        phrase: "Allahu Akbar",
        bgColor: const Color(0xFF3E2723),
        accentColor: Colors.orangeAccent,
      );
    } else {
      state = DhikrModel.initial();
    }
  }

  void _playCompletionSound() {
    try {
      _audioPlayer.play(AssetSource('assets/sounds/success.mp3'));
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }
}

final dhikrProvider = StateNotifierProvider<DhikrNotifier, DhikrModel>(
  (ref) => DhikrNotifier(),
);
