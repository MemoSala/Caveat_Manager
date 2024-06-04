import 'package:get/get.dart';

import '../core/class/directory_data.dart';
import '../core/class/file_inf.dart';
import '../core/class/files.dart';

class FilesController extends GetxController {
  DirectoryData directory = Files.getDirectorys();

  late List<FileInf> files;

  @override
  void onInit() {
    files = Files.getFiles;
    super.onInit();
  }
}
