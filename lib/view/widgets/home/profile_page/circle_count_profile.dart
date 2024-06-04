import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class CircleCountProfile extends StatelessWidget {
  const CircleCountProfile(
      {super.key, required this.value, required this.icon});

  final double value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: CircleProgressBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.white.withOpacity(0.2),
        value: value,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: AppColors.white, size: 16),
          AnimatedCount(
            fractionDigits: 0,
            count: value * 100,
            unit: "%",
            duration: const Duration(milliseconds: 500),
            style: const TextStyle(color: AppColors.white, height: 0.9),
          ),
        ]),
      ),
    );
  }
}
