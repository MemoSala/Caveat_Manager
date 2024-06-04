import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';

class TextMessageDialog extends StatelessWidget {
  const TextMessageDialog({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        inherit: false,
        fontFamily: "Caveat",
        color: AppColors.black,
        fontSize: 18,
      ),
    );
  }
}
