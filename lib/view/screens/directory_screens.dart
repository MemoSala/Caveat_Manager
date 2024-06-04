import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/directory_screens_controler.dart';
import '../../core/class/file_inf.dart';
import '../../core/class/file_type.dart';
import '../../core/constant/app_colors.dart';
import '../widgets/directory_screens/directory_button.dart';
import '../widgets/directory_screens/file_button.dart';

class DirectoryScreens extends StatelessWidget {
  const DirectoryScreens({super.key});

  @override
  Widget build(BuildContext context) {
    DirectoryScreensController controller =
        Get.put(DirectoryScreensController());
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<DirectoryScreensController>(
          builder: (controller) => Text(
            controller.filesSelect.isEmpty
                ? controller.name
                : "Selected ${controller.filesSelect.length} item${controller.filesSelect.length == 1 ? "" : "s"}",
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AnimateIcons(
            clockwise: true,
            controller: controller.animateIconController,
            startIcon: Icons.adaptive.arrow_back,
            endIcon: Icons.close,
            size: 32,
            onStartIconPress: () {
              controller.removeTag();
              return false;
            },
            onEndIconPress: () {
              controller.removeTag();
              return true;
            },
            duration: const Duration(milliseconds: 400),
            endIconColor: AppColors.secondary,
            startIconColor: AppColors.secondary,
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          controller.removeTag();
        },
        child: GetBuilder<DirectoryScreensController>(builder: (controller) {
          return GridView(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            children: [
              if (controller.directory != null)
                for (FileInf file in controller.directory!.files)
                  Builder(builder: (context) {
                    switch (file.type) {
                      case FileType.directory:
                        return DirectoryButton(
                          directory: file,
                          onPressed: () => controller.addTag(file),
                          onLongPress: () => controller.select(file),
                          isSelect: controller.filesSelect
                              .any((element) => element.path == file.path),
                        );

                      default:
                        return FileButton(
                          file: file,
                          onPressed: () => controller.openFile(file),
                          onLongPress: () => controller.select(file),
                          isSelect: controller.filesSelect
                              .any((element) => element.path == file.path),
                        );
                    }
                  }),
            ],
          );
        }),
      ),
      bottomNavigationBar: GetBuilder<DirectoryScreensController>(
        builder: (controller) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: AppColors.secondary.withOpacity(0.05),
            height: controller.filesSelect.isEmpty ? 0 : 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonSettingDirectory(
                  onPressed: () {},
                  icon: Icons.cut_rounded,
                  text: "Move",
                ),
                ButtonSettingDirectory(
                  onPressed: () {},
                  icon: Icons.copy,
                  text: "Copy",
                ),
                ButtonSettingDirectory(
                  onPressed: controller.delete,
                  icon: Icons.delete_outlined,
                  text: "Delete",
                ),
                ButtonSettingDirectory(
                  onPressed: () {},
                  icon: Icons.lock_outlined,
                  text: "Make\nPrivate",
                ),
                ButtonSettingDirectory(
                  onPressed: controller.filesSelect.length == 1
                      ? controller.rename
                      : null,
                  icon: Icons.edit_outlined,
                  text: "Rename",
                ),
                ButtonSettingDirectory(
                  onPressed: controller.filesSelect.length == 1 ? () {} : null,
                  icon: Icons.open_in_browser_outlined,
                  text: "Open in\nanother app",
                ),
                ButtonSettingDirectory(
                  onPressed: controller.derails,
                  icon: Icons.more_horiz_outlined,
                  text: "Derails",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ButtonSettingDirectory extends StatelessWidget {
  const ButtonSettingDirectory({
    super.key,
    this.onPressed,
    required this.icon,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
        ),
        Transform.translate(
          offset: const Offset(0, -10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1,
              color: onPressed != null
                  ? AppColors.secondary
                  : AppColors.secondary.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
