import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/file_inf.dart';
import '../../../../core/class/file_type.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_routes.dart';

class CategoryHomePage extends StatelessWidget {
  const CategoryHomePage({super.key, required this.color, required this.files});
  final List<FileInf> files;
  final Color color;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> list = [
      {
        "img": "assets/images/file_image.png",
        "text": "Images",
        "file_count":
            "${files.where((element) => element.type == FileType.photo).length} Files"
      },
      {
        "img": "assets/images/file_video.png",
        "text": "Videos",
        "file_count":
            "${files.where((element) => element.type == FileType.video).length} Files"
      },
      {
        "img": "assets/images/file_music.png",
        "text": "Music",
        "file_count":
            "${files.where((element) => element.type == FileType.audio).length} Files"
      },
      {
        "img": "assets/images/file_document.png",
        "text": "Documents",
        "file_count":
            "${files.where((element) => element.type == FileType.documents).length} Files"
      },
      {
        "img": "assets/images/file_android.png",
        "text": "Apk",
        "file_count":
            "${files.where((element) => element.type == FileType.apk).length} Files"
      },
      {
        "img": "assets/images/file_zip.png",
        "text": "ZIP",
        "file_count":
            "${files.where((element) => element.type == FileType.zip).length} Files"
      },
      {
        "img": "assets/images/folder.png",
        "text": "Other",
        "file_count":
            "${files.where((element) => element.type == FileType.other).length} Files"
      },
      {
        "img": "assets/images/file_trash.png",
        "text": "Trash",
        "file_count": "0 Files"
      },
    ];

    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
      ),
      children: List.generate(list.length, (index) {
        return MaterialButton(
          onPressed: () => Get.toNamed(
            AppRoutes.directoryScreens,
            arguments: list[index]["text"]!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          minWidth: 0,
          elevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(color: AppColors.white),
                foregroundDecoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.hue,
                  color: color.withOpacity(0.8),
                ),
                child: Image.asset(
                  list[index]["img"]!,
                  width: 30,
                ),
              ),
              Text(
                list[index]["text"]!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                list[index]["file_count"]!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary.withOpacity(0.5),
                  height: 0.5,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
