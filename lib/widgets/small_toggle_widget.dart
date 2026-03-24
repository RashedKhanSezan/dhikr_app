import 'package:flutter/material.dart';

class SmallToggle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SmallToggle({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white70, size: 28),
      ),
    );
  }
}
