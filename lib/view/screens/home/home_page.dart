import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/home_page_controller.dart';
import '../../../core/constant/app_colors.dart';
// import '../../../core/constant/app_routes.dart';
// import '../../widgets/home/home_page/game_home_page.dart';
import '../../widgets/home/home_page/rrcent_files_home_page.dart';
import '../../widgets/home/home_page/storage_box_home_page.dart';
import '../../widgets/home/home_page/text_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
            height: 120 + 199,
            child: GetBuilder<HomePageController>(
              builder: (controller) => PageView(
                controller: PageController(viewportFraction: 0.92),
                children: [
                  StorageBoxHomePage(
                    title: "My Storage",
                    average: controller.averageStorage,
                    free: controller.freeStorage,
                    tatal: controller.tatalStorage,
                    color: AppColors.primary,
                    files: controller.filesController.files,
                  ),
                  StorageBoxHomePage(
                    title: "My Cloud",
                    average: controller.averageCloud,
                    free: controller.freeCloud,
                    tatal: controller.tatalCloud,
                    color: AppColors.red,
                    files: const [],
                  ),
                ],
              ),
            ),
          ),
          const TextHomePage(text: "Rrcent Files"),
          RrcentFilesHomePage(
            list: controller.recentFilesJson,
          ),
          // const TextHomePage(text: "Game"),
          // GameHomePage(
          //   onPressed: () => Get.toNamed(AppRoutes.oneGame),
          //   image: "assets/images/oneGame.png",
          //   text: "One Game",
          // ),
        ]),
      ),
    );
  }
}
