import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dhikr_provider.dart';
import 'package:dhikr_app/widgets/glass_counter_widget.dart';

class DhikrScreen extends ConsumerWidget {
  const DhikrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dhikrProvider);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        color: data.bgColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.phrase,
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w200,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 50),
            GlassCounter(
              count: data.count,
              dhikr: data.phrase,
              accentColor: data.accentColor,
              onTap: () => ref.read(dhikrProvider.notifier).increment(),
            ),
          ],
        ),
      ),
    );
  }
}
