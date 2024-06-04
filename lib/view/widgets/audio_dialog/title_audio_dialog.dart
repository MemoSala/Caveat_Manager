import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';

class TitleAudioDialog extends StatelessWidget {
  const TitleAudioDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          inherit: false,
        ),
      ),
    );
  }
}
