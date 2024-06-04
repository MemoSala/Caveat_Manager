import 'dart:io';

import 'package:new_app/core/class/file_inf.dart';
import 'package:path/path.dart';

import 'directory_data.dart';
import 'file_type.dart';

class Files {
  static DirectoryData getDirectorys({
    String nameDir = '/storage/emulated/0/',
  }) {
    List<FileInf> files = [];
    List<FileInf> directorys = [];
    Directory dir = Directory(nameDir);
    List<FileSystemEntity> dirs;
    dirs = dir.listSync();
    for (FileSystemEntity entity in dirs) {
      if (!basename(entity.path).startsWith(".")) {
        if (entity is Directory) {
          directorys.add(FileInf(entity, type: FileType.directory));
        } else if (entity is File) {
          String path = entity.path;
          FileType type = fileType(path);
          files.add(FileInf(entity, type: type));
        }
      }
    }
    files.sort(
      (a, b) => FileStat.statSync(a.path).accessed.compareTo(
            FileStat.statSync(b.path).accessed,
          ),
    );
    directorys.sort(
      (a, b) => FileStat.statSync(a.path).accessed.compareTo(
            FileStat.statSync(b.path).accessed,
          ),
    );

    return DirectoryData(
      dir: FileInf(dir, type: FileType.directory),
      files: directorys + files,
    );
  }

  static List<FileInf> get getFiles {
    List<FileInf> files = [];
    Directory dir = Directory('/storage/emulated/0/');
    List<FileSystemEntity> dirs;
    dirs = dir.listSync();
    dirs.removeWhere(
      (element) =>
          element.path == '/storage/emulated/0/FileManager' ||
          element.path == '/storage/emulated/0/Android' ||
          element.path == '/storage/emulated/0/SHAREit' ||
          element.path.startsWith("/storage/emulated/0/."),
    );
    List<FileSystemEntity> directorys = [];
    for (FileSystemEntity entity in dirs) {
      if (entity is Directory && !basename(entity.path).startsWith(".")) {
        directorys.addAll(entity.listSync(recursive: true, followLinks: false));
      }
    }
    for (FileSystemEntity entity in directorys) {
      if (entity is File && !basename(entity.path).startsWith(".")) {
        String path = entity.path;
        FileType type = fileType(path);
        files.add(FileInf(entity, type: type));
      }
    }
    files.sort(
      (a, b) => FileStat.statSync(a.path).accessed.compareTo(
            FileStat.statSync(b.path).accessed,
          ),
    );
    return files;
  }

  static FileType fileType(String path) {
    if (isPhoto(path)) {
      return FileType.photo;
    } else if (isVideo(path)) {
      return FileType.video;
    } else if (isAudio(path)) {
      return FileType.audio;
    } else if (isDocuments(path)) {
      return FileType.documents;
    } else if (isApk(path)) {
      return FileType.apk;
    } else if (isZip(path)) {
      return FileType.zip;
    } else {
      return FileType.other;
    }
  }

  static bool isDocuments(String path) =>
      path.endsWith('.txt') || path.endsWith('.rtf') || path.endsWith('.docx');
  static bool isAudio(String path) =>
      path.endsWith('.mp3') ||
      path.endsWith('.wma') ||
      path.endsWith('.flac') ||
      path.endsWith('.aiff');
  static bool isVideo(String path) =>
      path.endsWith('.mp4') || path.endsWith('.mkv');
  static bool isPhoto(String path) =>
      path.endsWith('.png') ||
      path.endsWith('.jpg') ||
      path.endsWith('.bmp') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.gif') ||
      path.endsWith('.webp');

  static bool isApk(String path) => path.endsWith('.apk');
  static bool isZip(String path) =>
      path.endsWith('.zip') || path.endsWith('.rar');
}
