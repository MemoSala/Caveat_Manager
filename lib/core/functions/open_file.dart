import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/dialogs/audio_dialog.dart';
import '../../view/dialogs/video_dialog.dart';
import '../class/file_inf.dart';
import '../class/file_type.dart';

Future<void> openFile(FileInf file) async {
  if (file.type == FileType.photo) {
    await Get.dialog(Center(child: Image.file(File(file.path))));
  } else if (file.type == FileType.audio) {
    await Get.dialog(const AudioDialog(), arguments: file);
  } else if (file.type == FileType.video) {
    await Get.dialog(VideoDialog(file: file));
  }
}
