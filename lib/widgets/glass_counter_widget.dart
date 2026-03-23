import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCounter extends StatelessWidget {
  final int count;
  final String dhikr;
  final Color accentColor;
  final VoidCallback onTap;

  const GlassCounter({
    super.key,
    required this.count,
    required this.dhikr,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(110),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: accentColor.withOpacity(0.4),
              highlightColor: Colors.transparent,
              onTap: onTap,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dhikr),
                    Text(
                      "$count",
                      style: TextStyle(
                        fontSize: 80,
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
    );
  }
}
