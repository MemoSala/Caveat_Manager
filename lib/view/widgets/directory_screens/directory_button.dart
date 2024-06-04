import 'package:flutter/material.dart';
import 'package:new_app/core/class/file_inf.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/functions/directoy_image.dart';

class DirectoryButton extends StatelessWidget {
  const DirectoryButton({
    super.key,
    required this.directory,
    required this.onPressed,
    required this.onLongPress,
    required this.isSelect,
  });

  final FileInf directory;
  final bool isSelect;
  final void Function() onPressed, onLongPress;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: onLongPress,
      onPressed: onPressed,
      color: AppColors.secondary.withOpacity(0.05),
      height: double.infinity,
      minWidth: double.infinity,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelect
            ? const BorderSide(color: AppColors.black)
            : BorderSide.none,
      ),
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            directoryImages(directory.name),
            width: 55,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${directory.name} ( ${directory.length} )",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
