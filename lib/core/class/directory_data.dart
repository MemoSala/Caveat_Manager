import 'file_inf.dart';

class DirectoryData {
  final FileInf? dir;
  List<FileInf> files;

  DirectoryData({
    this.dir,
    this.files = const [],
  });
}
