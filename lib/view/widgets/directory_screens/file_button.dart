import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/class/file_inf.dart';
import '../../../core/class/file_type.dart';
import '../../../core/constant/app_colors.dart';

class FileButton extends StatelessWidget {
  const FileButton({
    super.key,
    required this.file,
    required this.onPressed,
    required this.onLongPress,
    required this.isSelect,
  });

  final FileInf file;
  final bool isSelect;
  final void Function() onPressed, onLongPress;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
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
      child: Column(children: [
        Expanded(
          child: file.image(
            margin: 0,
            borderRadius: 12,
            height: double.infinity,
            width: double.infinity,
            isForeground: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/${file.type == FileType.photo ? "image" : file.type == FileType.video ? "video" : file.type == FileType.audio ? 'audio' : "file"}.svg",
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
                width: 13,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
