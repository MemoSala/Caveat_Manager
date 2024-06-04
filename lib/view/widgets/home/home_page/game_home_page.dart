import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class GameHomePage extends StatelessWidget {
  const GameHomePage({
    super.key,
    required this.onPressed,
    required this.image,
    required this.text,
  });
  final void Function() onPressed;
  final String image, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: onPressed,
        height: 200,
        color: AppColors.secondary.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        elevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        padding: const EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.bottomCenter,
          child: BlurryContainer(
            blur: 5,
            padding: const EdgeInsets.all(0),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
            child: Container(
              height: 45,
              color: AppColors.black.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(color: AppColors.white.withOpacity(0.8)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
