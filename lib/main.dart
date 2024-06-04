import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller/files_controller.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void future() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    future();
    Get.put(FilesController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Caveat Manager",
      theme: ThemeData(fontFamily: "Caveat"),
      getPages: routes,
    );
  }
}
