import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late PageController pageController;
  int pageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void goAnimateToPage(int index) async {
    pageIndex = index;
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void goToPage(int index) {
    pageIndex = index;
    update();
  }
}
