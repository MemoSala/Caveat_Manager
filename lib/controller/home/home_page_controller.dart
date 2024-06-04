import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:get/get.dart';

import '../../core/class/file_inf.dart';
import '../files_controller.dart';

class HomePageController extends GetxController {
  List<FileInf> recentFilesJson = [];
  FilesController filesController = Get.find();
  double tatalStorage = 0, freeStorage = 0, averageStorage = 0;
  double tatalCloud = 15 * 1024, freeCloud = 2.5 * 1024, averageCloud = 0;
  @override
  void onInit() async {
    if (filesController.files.length > 5) {
      recentFilesJson.addAll(filesController.files.sublist(0, 5));
    } else {
      recentFilesJson.addAll(filesController.files);
    }
    averageCloud = freeCloud / tatalCloud;
    tatalStorage = await DiskSpacePlus.getTotalDiskSpace ?? -1;
    freeStorage = tatalStorage - (await DiskSpacePlus.getFreeDiskSpace ?? 0);
    averageStorage = freeStorage / tatalStorage;
    update();
    super.onInit();
  }
}
