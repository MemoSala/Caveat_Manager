import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/home/home_page_controller.dart';

import '../files_controller.dart';

class ProfilePageController extends GetxController {
  PageController pageController = PageController();
  double initialPage = 0;
  FilesController filesController = Get.find();
  HomePageController homePageController = Get.find();
  late double averageStorage, averageCloud;
  @override
  void onInit() async {
    averageCloud = homePageController.averageCloud;
    averageStorage = homePageController.averageStorage;
    super.onInit();
  }

  void toPage(int page) {
    initialPage = page.toDouble();
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    update();
  }
}
