import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';

class ButtonMessageDialog extends StatelessWidget {
  const ButtonMessageDialog(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
      child: Text(
        text,
        style: const TextStyle(
          inherit: false,
          fontFamily: "Caveat",
          color: AppColors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
