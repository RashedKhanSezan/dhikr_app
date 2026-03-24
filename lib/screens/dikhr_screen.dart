import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dhikr_app/providers/dhikr_provider.dart';
import 'package:dhikr_app/widgets/glass_counter_widget.dart';
import 'package:dhikr_app/widgets/stat_chip_widget.dart';
import 'package:dhikr_app/widgets/small_toggle_widget.dart';
import 'package:dhikr_app/widgets/dialog_widget.dart';
import 'package:dhikr_app/widgets/action_button.dart';

class DhikrScreen extends ConsumerWidget {
  const DhikrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dhikrProvider);
    final notifier = ref.read(dhikrProvider.notifier);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        color: data.bgColor,
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "Dhikr App",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  StatChip(
                    label: "SubhanAllah",
                    total: data.totalSubhanAllah,
                    arabicText: "سبحان الله",
                    isActive: data.phrase == "SubhanAllah",
                    onTap: () => notifier.setPhase("SubhanAllah"),
                  ),
                  StatChip(
                    label: "Alhamdulillah",
                    total: data.totalAlhamdulillah,
                    arabicText: "الحمد لله",
                    isActive: data.phrase == "Alhamdulillah",
                    onTap: () => notifier.setPhase("Alhamdulillah"),
                  ),
                  StatChip(
                    label: "Allahu Akbar",
                    total: data.totalAllahuAkbar,
                    arabicText: "الله أكبر",
                    isActive: data.phrase == "Allahu Akbar",
                    onTap: () => notifier.setPhase("Allahu Akbar"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: notifier.start33Session,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: data.isAutoSession ? data.accentColor : Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Start 3 × 33 Session",
                  style: TextStyle(
                    color: Color.fromARGB(237, 255, 255, 255),

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Total Sessions: ${data.sessionsCompleted}",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionBtn(
                    icon: Icons.remove,
                    label: "Decrease",
                    onTap: () => showDialog(
                      context: context,
                      builder: (c) => ModernAlertDialog(
                        title: "Decrease?",
                        description: "Remove 1 from count?",
                        icon: Icons.remove_circle,
                        accentColor: Colors.redAccent,
                        onConfirm: notifier.decrement,
                      ),
                    ),
                  ),
                  ActionBtn(
                    icon: Icons.refresh,
                    label: "Reset All",
                    onTap: () => showDialog(
                      context: context,
                      builder: (c) => ModernAlertDialog(
                        title: "Reset All?",
                        description: "Clear sessions and totals?",
                        icon: Icons.refresh,
                        accentColor: data.accentColor,
                        onConfirm: notifier.resetAll,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            GlassCounter(
              arabicText: data.arabicText,
              count: data.count,
              phrase: data.phrase,
              translation: data.translation,

              accentColor: data.accentColor,
              isAutoSession: data.isAutoSession,
              onTap: () => notifier.increment(context),
            ),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 30),
              child: Row(
                children: [
                  SmallToggle(
                    icon: data.isSoundOn ? Icons.volume_up : Icons.volume_off,
                    onTap: notifier.toggleSound,
                  ),
                  const SizedBox(width: 15),
                  SmallToggle(
                    icon: data.isVibrationOn
                        ? Icons.vibration
                        : Icons.smartphone,
                    onTap: notifier.toggleVibration,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
