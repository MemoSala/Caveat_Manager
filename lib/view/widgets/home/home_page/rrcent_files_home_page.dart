import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/class/file_inf.dart';
import '../../../../core/class/file_type.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/functions/open_file.dart';

class RrcentFilesHomePage extends StatelessWidget {
  const RrcentFilesHomePage({super.key, required this.list});
  final List<FileInf> list;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
      child: Row(
        children: List.generate(list.length, (index) {
          return GestureDetector(
            onTap: () => openFile(list[index]),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                width: 240,
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 7.5),
                padding: const EdgeInsets.only(bottom: 45),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    right: -30,
                    bottom: -40,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.white.withOpacity(0.2),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    top: -10,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.white.withOpacity(0.2),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 10,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.white.withOpacity(0.2),
                    ),
                  ),
                  Positioned(
                    left: 25,
                    bottom: 15,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.white.withOpacity(0.2),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/${list[index].type == FileType.photo ? "image" : list[index].type == FileType.video ? "video" : list[index].type == FileType.audio ? 'audio' : "file"}.svg",
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                    width: 80,
                  ),
                ]),
              ),
              list[index].image(),
              BlurryContainer(
                blur: 5,
                padding: const EdgeInsets.all(0),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
                child: Container(
                  width: 240,
                  height: 45,
                  color: AppColors.black.withOpacity(0.4),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(children: [
                    SvgPicture.asset(
                      "assets/icons/${list[index].type == FileType.photo ? "image" : list[index].type == FileType.video ? "video" : list[index].type == FileType.audio ? 'audio' : "file"}.svg",
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                      width: 15,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        list[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: AppColors.white.withOpacity(0.8)),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
          );
        }),
      ),
    );
  }
}
