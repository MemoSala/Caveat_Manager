import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MessageDialogController extends GetxController {
  bool isLoading = false;

  late TextEditingController nameFile;

  void editNameFile(String text) {
    nameFile = TextEditingController(text: text);
  }

  GlobalKey<FormState> static = GlobalKey();

  void loading() {
    isLoading = true;
    update();
  }

  void stopLoading() {
    isLoading = false;
    update();
  }
}
