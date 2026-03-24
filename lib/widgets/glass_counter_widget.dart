import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCounter extends StatelessWidget {
  final int count;
  final String phrase;
  final String arabicText;
  final String translation;
  final Color accentColor;
  final VoidCallback onTap;
  final bool isAutoSession;

  const GlassCounter({
    super.key,
    required this.count,
    required this.phrase,
    required this.arabicText,
    required this.translation,
    required this.accentColor,
    required this.onTap,
    required this.isAutoSession,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 320,
          height: 320,
          child: isAutoSession
              ? CircularProgressIndicator(
                  value: count / 33,
                  strokeWidth: 8,
                  color: accentColor.withOpacity(0.5),
                  backgroundColor: Colors.white10,
                )
              : const SizedBox.shrink(),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Material(
              color: Colors.white.withOpacity(0.08),
              child: InkWell(
                onTap: onTap,
                splashColor: accentColor.withOpacity(
                  0.2,
                ), 
                highlightColor: accentColor.withOpacity(0.1),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        arabicText,
                        style: const TextStyle(
                          fontSize: 46,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        phrase,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        translation,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "$count",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
