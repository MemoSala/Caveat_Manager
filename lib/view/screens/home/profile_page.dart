import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/profile_page_controller.dart';
import '../../../core/class/file_inf.dart';
import '../../../core/class/file_type.dart';
import '../../../core/constant/app_colors.dart';
import '../../widgets/home/profile_page/circle_count_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width - 60;
    ProfilePageController controller = Get.put(ProfilePageController());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Row(children: [
          Container(
            height: width - 40,
            width: width / 2,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                  backgroundBlendMode: BlendMode.colorBurn,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                child: Opacity(
                  opacity: 0.7,
                  child: CircleAvatar(
                    radius: width / 4 - 19,
                    backgroundColor: AppColors.primary,
                    backgroundImage: const AssetImage("assets/images/Por.png"),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Mo'men Salah",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                "momensalah1223@gmail.com",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondary,
                  height: .8,
                ),
              ),
              const Text(
                "2024 June 26",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.1,
                  fontSize: 14,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_outlined),
                ),
              ]),
            ]),
          ),
          Column(children: [
            Container(
              height: width / 2 - 60,
              width: width / 2,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.9),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleCountProfile(
                    value: controller.averageStorage,
                    icon: Icons.storage_rounded,
                  ),
                  CircleCountProfile(
                    value: controller.averageCloud,
                    icon: Icons.cloud_outlined,
                  ),
                ],
              ),
            ),
            Container(
              height: width / 2,
              width: width / 2,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(children: [
                GetBuilder<ProfilePageController>(builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedIconButton(
                        onPressed: () => controller.toPage(0),
                        icon: Icons.storage_rounded,
                        tween: 1 - controller.initialPage,
                      ),
                      AnimatedIconButton(
                        onPressed: () => controller.toPage(1),
                        icon: Icons.cloud_outlined,
                        tween: controller.initialPage,
                      ),
                    ],
                  );
                }),
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FilesListProfile(files: controller.filesController.files),
                      const FilesListProfile(files: []),
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ]),
        BuySpaceProfile(
          color: AppColors.primary.withOpacity(0.9),
          title: 'Free',
          description: "Space will be up to 15 GB",
          price: "Free",
          isFree: true,
        ),
        BuySpaceProfile(
          color: AppColors.red.withOpacity(0.9),
          title: 'Normal',
          description: "Space will be up to 30 GB",
          price: "5 \$",
        ),
        BuySpaceProfile(
          color: AppColors.goden.withOpacity(0.9),
          title: 'Super',
          description: "Space will be up to 60 GB",
          price: "10 \$",
        ),
      ]),
    );
  }
}

class BuySpaceProfile extends StatelessWidget {
  const BuySpaceProfile({
    super.key,
    required this.color,
    required this.title,
    required this.description,
    required this.price,
    this.isFree = false,
  });
  final Color color;
  final bool isFree;
  final String title, description, price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(children: [
        Positioned(
          right: -30,
          bottom: -50,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: AppColors.white.withOpacity(0.2),
          ),
        ),
        Positioned(
          left: -30,
          bottom: -10,
          child: CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.white.withOpacity(0.2),
          ),
        ),
        Positioned(
          left: 15,
          top: 5,
          child: CircleAvatar(
            radius: 5,
            backgroundColor: AppColors.white.withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 10,
            right: 15,
            left: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(description,
                    style: const TextStyle(color: AppColors.white)),
                MaterialButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  textColor: isFree ? AppColors.black : AppColors.white,
                  color: !isFree ? AppColors.black : AppColors.white,
                  minWidth: 80,
                  height: 0,
                  elevation: 0,
                  focusElevation: 0,
                  hoverElevation: 0,
                  disabledElevation: 0,
                  highlightElevation: 0,
                  child: Text(price),
                )
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}

class AnimatedIconButton extends StatelessWidget {
  const AnimatedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tween,
  });
  final void Function() onPressed;
  final IconData icon;
  final double tween;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: tween, end: tween),
      builder: (context, value, child) => MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: AppColors.secondary.withOpacity(value),
        textColor: Color.fromARGB(
          255,
          (43 + 212 * value).toInt(),
          (43 + 212 * value).toInt(),
          (43 + 212 * value).toInt(),
        ),
        padding: const EdgeInsets.all(5),
        minWidth: 0,
        height: 0,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        child: child,
      ),
      child: Icon(icon, size: 16),
    );
  }
}

class FilesListProfile extends StatelessWidget {
  const FilesListProfile({super.key, required this.files});
  final List<FileInf> files;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> list = [
      {
        "text": "Images",
        "file_count":
            "${files.where((element) => element.type == FileType.photo).length}"
      },
      {
        "text": "Videos",
        "file_count":
            "${files.where((element) => element.type == FileType.video).length}"
      },
      {
        "text": "Music",
        "file_count":
            "${files.where((element) => element.type == FileType.audio).length}"
      },
      {
        "text": "Documents",
        "file_count":
            "${files.where((element) => element.type == FileType.documents).length}"
      },
      {
        "text": "Other",
        "file_count":
            "${files.where((element) => element.type == FileType.other || element.type == FileType.apk || element.type == FileType.zip).length}"
      },
    ];

    return Column(children: [
      for (Map<String, String> event in list)
        Row(children: [
          SizedBox(
            width: 80,
            child: Text(
              "- ${event["text"]}:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("${event["file_count"]} Files"),
        ]),
    ]);
  }
}
