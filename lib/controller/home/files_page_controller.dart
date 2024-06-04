import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class FilesPageController extends GetxController {
  int pageIndex = 0;
  List<String> storages = [], storagesname = [];

  void goToPage(int index) {
    pageIndex = index;
    update();
  }

  @override
  void onInit() async {
    try {
      storages = await ExternalPath.getExternalStorageDirectories() + [""];
      for (String element in storages) {
        if (element == "/storage/emulated/0") {
          storagesname.add("My Storage");
        } else if (element == "") {
          storagesname.add("My Cloud");
        } else {
          storagesname.add(basename(element));
        }
      }
    } catch (e) {
      storagesname = ["My Storage", "My Cloud"];
      storages = ["/storage/emulated/0", ""];
      Get.dialog(Center(
        child: Container(
          color: Colors.white,
          child: Text(
            e.toString(),
            style: const TextStyle(color: Colors.black, inherit: false),
          ),
        ),
      ));
    }
    update();
    super.onInit();
  }
}
