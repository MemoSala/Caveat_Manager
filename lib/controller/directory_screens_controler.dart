import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/files_controller.dart';
import 'package:path/path.dart';

import '../core/class/directory_data.dart';
import '../core/class/file_inf.dart';
import '../core/class/file_type.dart';
import '../core/class/files.dart';
import '../../core/functions/open_file.dart' as fu;
import '../view/dialogs/message_dialog.dart';
import '../view/dialogs/message_dialog_rename.dart';

class DirectoryScreensController extends GetxController {
  late String tag, name;
  AnimateIconController animateIconController = AnimateIconController();
  List<String> tags = [];
  DirectoryData? directory;
  FilesController filesController = Get.find();
  List<FileInf> filesSelect = [];
  @override
  void onInit() {
    tag = Get.arguments;
    if (tag == "Images") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.photo)
            .toList(),
      );
    } else if (tag == "Videos") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.video)
            .toList(),
      );
    } else if (tag == "Music") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.audio)
            .toList(),
      );
    } else if (tag == "Documents") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.documents)
            .toList(),
      );
    } else if (tag == "ZIP") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.zip)
            .toList(),
      );
    } else if (tag == "Apk") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.apk)
            .toList(),
      );
    } else if (tag == "Other") {
      name = tag;
      directory = DirectoryData(
        files: filesController.files
            .where((element) => element.type == FileType.other)
            .toList(),
      );
    } else if (tag == "Trash") {
      name = tag;
      directory = DirectoryData();
    } else {
      FileInf dir = FileInf(Directory(tag), type: FileType.directory);
      List<FileInf> directorys = Directory(tag)
          .listSync()
          .whereType<Directory>()
          .map((e) => FileInf(e, type: FileType.directory))
          .toList();
      List<FileInf> files = Directory(tag)
          .listSync()
          .whereType<File>()
          .map((e) => FileInf(e, type: Files.fileType(e.path)))
          .toList();
      directory = DirectoryData(dir: dir, files: directorys + files);
      name = dir.name;
    }
    super.onInit();
  }

  void addTag(FileInf directoryInf) {
    if (filesSelect.isEmpty) {
      tags.add(directoryInf.name);
      String tag = this.tag;
      for (String v in tags) {
        tag += "/$v";
      }
      FileInf dir = FileInf(Directory(tag), type: FileType.directory);
      List<FileInf> directorys = Directory(tag)
          .listSync()
          .whereType<Directory>()
          .map((e) => FileInf(e, type: FileType.directory))
          .toList();
      List<FileInf> files = Directory(tag)
          .listSync()
          .whereType<File>()
          .map((e) => FileInf(e, type: Files.fileType(e.path)))
          .toList();
      directory = DirectoryData(dir: dir, files: directorys + files);
      name = dir.name;
      update();
    } else {
      select(directoryInf);
    }
  }

  void openFile(FileInf file) {
    if (filesSelect.isEmpty) {
      fu.openFile(file);
    } else {
      select(file);
    }
  }

  void removeTag() {
    if (filesSelect.isNotEmpty) {
      filesSelect = [];
      update();
    } else if (tags.isNotEmpty) {
      tags.removeAt(tags.length - 1);
      String tag = this.tag;
      for (String v in tags) {
        tag += "/$v";
      }
      FileInf dir = FileInf(Directory(tag), type: FileType.directory);
      List<FileInf> directorys = Directory(tag)
          .listSync()
          .whereType<Directory>()
          .map((e) => FileInf(e, type: FileType.directory))
          .toList();
      List<FileInf> files = Directory(tag)
          .listSync()
          .whereType<File>()
          .map((e) => FileInf(e, type: Files.fileType(e.path)))
          .toList();
      directory = DirectoryData(dir: dir, files: directorys + files);
      name = dir.name;
      update();
    } else {
      Future.delayed(Duration.zero, () {
        Get.back();
      });
    }
  }

  void select(FileInf fileSystem) {
    if (filesSelect.any((element) => element.path == fileSystem.path)) {
      filesSelect.removeWhere((element) => element.path == fileSystem.path);
      if (filesSelect.isEmpty) animateIconController.animateToStart();
    } else {
      animateIconController.animateToEnd();
      filesSelect.add(fileSystem);
    }
    update();
  }

// ---------------------------------------------------------------------------

  void delete() async {
    Get.dialog(MessageDialog(
      text: "Are you sure you want to delete the file?",
      onPressed: () async {
        for (FileInf file in filesSelect) {
          await file.delete();
          if (file is File) {
            filesController.files.removeWhere(
              (element) => element.path == file.path,
            );
          }
          directory?.files.removeWhere((element) => element.path == file.path);
        }
        filesSelect = [];
        update();
      },
    ));
  }

  void rename() async {
    Get.dialog(MessageDialogRename(
      text: basename(filesSelect.first.path),
      onPressed: (newPath) async {
        FileSystemEntity newFile = await filesSelect.first.rename(newPath);
        filesController.files.add(
          FileInf(newFile, type: Files.fileType(newFile.path)),
        );
        filesController.files.removeWhere(
          (element) => element.path == filesSelect.first.path,
        );
        directory?.files.add(
          FileInf(newFile, type: Files.fileType(newFile.path)),
        );
        directory?.files.removeWhere(
          (element) => element.path == filesSelect.first.path,
        );
        filesSelect = [];
        update();
      },
    ));
  }

  void derails() async {
    final stat = FileStat.statSync(filesSelect.first.path);
    Get.dialog(Center(
      child: Container(
        color: Colors.white,
        child: Text(
          "\nAccessed: ${stat.accessed}\nModified:  ${stat.modified}\nChanged:  ${stat.changed}\nSize:  ${stat.size}\nType:  ${stat.type.toString()}\nPath:  ${filesSelect.first.path}",
          style: const TextStyle(color: Colors.black, inherit: false),
        ),
      ),
    ));
  }
}
