import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/files_page_controller.dart';
import '../../../core/class/files.dart';
import '../../../core/shared/get_taps.dart';
import '../../../core/constant/app_colors.dart';
import '../../widgets/home/files_page/list_files_page.dart';
import '../../widgets/home/files_page/text_files_page.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FilesPageController());
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GetBuilder<FilesPageController>(
            builder: (controller) => GetTaps(
              initialPage: controller.pageIndex,
              children: controller.storagesname,
              onTap: controller.goToPage,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          const TextFilesPage(),
          GetBuilder<FilesPageController>(builder: (controller) {
            if (controller.storages.isNotEmpty) {
              return ListFilesPage(
                directory: controller.storages[controller.pageIndex] != ""
                    ? Files.getDirectorys(
                        nameDir: controller.storages[controller.pageIndex],
                      )
                    : null,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ]),
      ),
    );
  }
}
