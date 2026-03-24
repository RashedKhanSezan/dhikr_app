import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:dhikr_app/services/local_db.dart';

class DhikrNotifier extends StateNotifier<DhikrModel> {
  DhikrNotifier() : super(DhikrModel.initial()) {
    _loadFromDb();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _loadFromDb() async {
    final data = await LocalDb.instance.getDhikr();
    if (data != null) {
      state = _copy(
        count: data['count'],
        totalSubhanAllah: data['totalSubhanAllah'],
        totalAlhamdulillah: data['totalAlhamdulillah'],
        totalAllahuAkbar: data['totalAllahuAkbar'],
        sessionsCompleted: data['sessionsCompleted'],
        isSoundOn: data['isSoundOn'] == 1,
        isVibrationOn: data['isVibrationOn'] == 1,
      );
    }
  }

  void _saveToDb() => LocalDb.instance.updateDhikr(state);

  void toggleSound() {
    state = _copy(isSoundOn: !state.isSoundOn);
    _saveToDb();
  }

  void toggleVibration() {
    state = _copy(isVibrationOn: !state.isVibrationOn);
    _saveToDb();
  }

  void resetAll() {
    state = DhikrModel.initial();
    _saveToDb();
  }

  void start33Session() {
    state = _copy(
      count: 0,
      isAutoSession: true,
      phrase: "SubhanAllah",
      arabicText: "سبحان الله",
      translation: "Glory be to Allah",
      bgColor: const Color.fromARGB(255, 0, 77, 64),
      accentColor: const Color.fromARGB(164, 100, 255, 219),
    );
    _saveToDb();
    if (state.isVibrationOn) Vibration.vibrate(duration: 100);
  }

  void setPhase(String phrase) {
    if (phrase == "SubhanAllah") {
      state = _copy(
        count: 0,
        isAutoSession: false,
        phrase: "SubhanAllah",
        translation: "Glory be to Allah",
        arabicText: "سبحان الله",
        bgColor: const Color.fromARGB(255, 0, 77, 64),
        accentColor: const Color.fromARGB(164, 100, 255, 219),
      );
    } else if (phrase == "Alhamdulillah") {
      state = _copy(
        count: 0,
        isAutoSession: false,
        phrase: "Alhamdulillah",
        translation: "All praise belongs to Allah",
        arabicText: "الحمد لله",
        bgColor: const Color.fromARGB(166, 52, 58, 124),
        accentColor: const Color.fromARGB(171, 64, 195, 255),
      );
    } else if (phrase == "Allahu Akbar") {
      state = _copy(
        count: 0,
        isAutoSession: false,
        phrase: "Allahu Akbar",
        translation: "Allah is the Greatest",
        arabicText: "الله أكبر",
        bgColor: const Color.fromARGB(255, 62, 39, 35),
        accentColor: const Color.fromARGB(169, 255, 172, 64),
      );
    }
    _saveToDb();
  }

  void decrement() {
    if (state.count <= 0) return;
    state = _copy(count: state.count - 1);
    _saveToDb();
  }

  void increment(BuildContext context) async {
    int nextCount = state.count + 1;

    int tSub = state.phrase == "SubhanAllah"
        ? state.totalSubhanAllah + 1
        : state.totalSubhanAllah;
    int tAlh = state.phrase == "Alhamdulillah"
        ? state.totalAlhamdulillah + 1
        : state.totalAlhamdulillah;
    int tAkb = state.phrase == "Allahu Akbar"
        ? state.totalAllahuAkbar + 1
        : state.totalAllahuAkbar;

    if (state.isAutoSession) {
      if (nextCount == 33) {
        state = _copy(
          count: 33,
          totalSubhanAllah: tSub,
          totalAlhamdulillah: tAlh,
          totalAllahuAkbar: tAkb,
        );

        if (state.isVibrationOn) Vibration.vibrate(duration: 150);
        await Future.delayed(const Duration(milliseconds: 150));

        if (state.phrase == "Allahu Akbar") {
          if (state.isSoundOn) _playSuccessSound();
          state = _copy(sessionsCompleted: state.sessionsCompleted + 1);
          start33Session();
        } else {
          _autoTransition(tSub, tAlh, tAkb);
        }
      } else {
        if (state.isVibrationOn) Vibration.vibrate(duration: 40);
        state = _copy(
          count: nextCount,
          totalSubhanAllah: tSub,
          totalAlhamdulillah: tAlh,
          totalAllahuAkbar: tAkb,
        );
      }
    } else {
      if (state.isVibrationOn) Vibration.vibrate(duration: 40);
      state = _copy(
        count: nextCount,
        totalSubhanAllah: tSub,
        totalAlhamdulillah: tAlh,
        totalAllahuAkbar: tAkb,
      );
    }
    _saveToDb();
  }

  void _autoTransition(int s, int a, int k) {
    if (state.phrase == "SubhanAllah") {
      state = _copy(
        count: 0,
        totalSubhanAllah: s,
        phrase: "Alhamdulillah",
        arabicText: "الحمد لله",
        translation: "All praise belongs to Allah",
        bgColor: const Color.fromARGB(255, 52, 58, 124),
        accentColor: const Color.fromARGB(171, 64, 195, 255),
      );
    } else {
      state = _copy(
        count: 0,
        totalAlhamdulillah: a,
        phrase: "Allahu Akbar",
        arabicText: "الله أكبر",
        translation: "Allah is the Greatest",
        bgColor: const Color.fromARGB(255, 62, 39, 35),
        accentColor: const Color.fromARGB(169, 255, 172, 64),
      );
    }
  }

  void _playSuccessSound() {
    _audioPlayer.play(AssetSource('sounds/success.mp3'));
  }

  DhikrModel _copy({
    int? count,
    int? totalSubhanAllah,
    int? totalAlhamdulillah,
    int? totalAllahuAkbar,
    int? sessionsCompleted,
    String? phrase,
    String? arabicText,
    String? translation,
    Color? bgColor,
    Color? accentColor,
    bool? isSoundOn,
    bool? isVibrationOn,
    bool? isAutoSession,
  }) {
    return DhikrModel(
      count: count ?? state.count,
      totalSubhanAllah: totalSubhanAllah ?? state.totalSubhanAllah,
      totalAlhamdulillah: totalAlhamdulillah ?? state.totalAlhamdulillah,
      totalAllahuAkbar: totalAllahuAkbar ?? state.totalAllahuAkbar,
      sessionsCompleted: sessionsCompleted ?? state.sessionsCompleted,
      phrase: phrase ?? state.phrase,
      arabicText: arabicText ?? state.arabicText,
      translation: translation ?? state.translation,
      bgColor: bgColor ?? state.bgColor,
      accentColor: accentColor ?? state.accentColor,
      isSoundOn: isSoundOn ?? state.isSoundOn,
      isVibrationOn: isVibrationOn ?? state.isVibrationOn,
      isAutoSession: isAutoSession ?? state.isAutoSession,
    );
  }
}

final dhikrProvider = StateNotifierProvider<DhikrNotifier, DhikrModel>(
  (ref) => DhikrNotifier(),
);
