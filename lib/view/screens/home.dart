import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home/home_controller.dart';
import 'home/home_page.dart';
import 'home/files_page.dart';
import 'home/profile_page.dart';
import '../widgets/home/navigation_bar_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text("Caveat Manager")),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) => controller.goToPage(index),
        children: const [
          HomePage(),
          FilesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const NavigationBarHome(),
    );
  }
}
