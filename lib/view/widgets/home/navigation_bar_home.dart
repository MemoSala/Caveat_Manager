import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controller/home/home_controller.dart';
import '../../../data/data source/root_app.dart';

class NavigationBarHome extends StatelessWidget {
  const NavigationBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SalomonBottomBar(
        currentIndex: controller.pageIndex,
        onTap: (index) => controller.goAnimateToPage(index),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        items: List.generate(
          rootAppJson.length,
          (index) => SalomonBottomBarItem(
            selectedColor: rootAppJson[index]['color'],
            icon: SvgPicture.asset(
              rootAppJson[index]['icon'],
              colorFilter: ColorFilter.mode(
                rootAppJson[index]['color'],
                BlendMode.srcIn,
              ),
            ),
            title: Text(rootAppJson[index]['text']),
          ),
        ),
      ),
    );
  }
}
