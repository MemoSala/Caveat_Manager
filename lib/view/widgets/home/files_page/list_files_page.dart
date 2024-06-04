import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/class/directory_data.dart';
import '../../../../core/class/file_inf.dart';
import '../../../../core/class/file_type.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_routes.dart';
import '../../../../core/functions/directoy_image.dart';

class ListFilesPage extends StatelessWidget {
  const ListFilesPage({super.key, required this.directory});

  final DirectoryData? directory;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        if (directory != null)
          for (FileInf file in directory!.files)
            Builder(builder: (context) {
              switch (file.type) {
                case FileType.directory:
                  return MaterialButton(
                    onPressed: () => Get.toNamed(
                      AppRoutes.directoryScreens,
                      arguments: file.path,
                    ),
                    color: AppColors.secondary.withOpacity(0.05),
                    height: double.infinity,
                    minWidth: double.infinity,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                          directoryImages(file.name),
                          width: 55,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${file.name} ( ${file.length} )",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  );
                default:
                  return MaterialButton(
                    onPressed: () {},
                    color: AppColors.secondary.withOpacity(0.05),
                    height: double.infinity,
                    minWidth: double.infinity,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  );
              }
            }),
      ],
    );
  }
}
