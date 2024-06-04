import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/class/file_inf.dart';
import '../../../../core/constant/app_colors.dart';
import 'category_home_page.dart';

class StorageBoxHomePage extends StatelessWidget {
  const StorageBoxHomePage({
    super.key,
    required this.tatal,
    required this.free,
    required this.average,
    required this.title,
    required this.color,
    required this.files,
  });
  final double tatal, free, average;
  final String title;
  final Color color;
  final List<FileInf> files;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            right: -30,
            bottom: -40,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.white.withOpacity(0.2),
            ),
          ),
          Positioned(
            left: -50,
            bottom: -10,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.white.withOpacity(0.2),
            ),
          ),
          Row(children: [
            const SizedBox(width: 20),
            SizedBox(
              width: 80,
              height: 80,
              child: CircleProgressBar(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.white.withOpacity(0.2),
                value: average,
                child: Center(
                  child: AnimatedCount(
                    fractionDigits: 0,
                    count: average * 100,
                    unit: "%",
                    duration: const Duration(milliseconds: 500),
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${(free ~/ 10.24) / 100} GB of ${(tatal ~/ 10.24) / 100} GB used",
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ]),
        ]),
      ),
      const SizedBox(height: 20),
      CategoryHomePage(color: color, files: files),
    ]);
  }
}
