import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../constant/app_colors.dart';
import 'file_type.dart';

class FileInf {
  final FileSystemEntity _file;
  final FileType type;

  FileInf(this._file, {required this.type});

  String get path => _file.path;

  Future<Metadata>? get metd {
    switch (type) {
      case FileType.directory:
        return null;
      default:
        return MetadataRetriever.fromFile(_file as File);
    }
  }

  String get name {
    String path = basename(_file.path);
    switch (type) {
      case FileType.directory:
        return path;
      default:
        return path.replaceRange(
          path.length - 1 - path.split('.').last.length,
          null,
          "",
        );
    }
  }

  int? get length {
    switch (type) {
      case FileType.directory:
        return (_file as Directory).listSync().length;
      default:
        return null;
    }
  }

  Future<int> get size async {
    switch (type) {
      case FileType.directory:
        List<File> files = (_file as Directory)
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .toList();
        int dirSize = 0;
        for (File file in files) {
          dirSize += await file.length();
        }
        return dirSize;
      default:
        return (_file as File).length();
    }
  }

  Future<FileSystemEntity> rename(String newName) =>
      _file.rename("${_file.parent.path}/$newName");

  Future<void> delete() => _file.delete();

  Widget image({
    double width = 240,
    double height = 160,
    double borderRadius = 22,
    double margin = 7.5,
    bool isForeground = false,
  }) {
    if (type == FileType.audio) {
      return FutureBuilder(
        future: metd,
        builder: (context, snaphot) => Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: margin),
          decoration: isForeground
              ? BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : null,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: snaphot.hasData
                ? snaphot.data != null
                    ? snaphot.data!.albumArt != null
                        ? DecorationImage(
                            image: MemoryImage(snaphot.data!.albumArt!),
                            fit: BoxFit.cover,
                          )
                        : null
                    : null
                : null,
          ),
          child: isForeground ? _foreground(borderRadius: borderRadius) : null,
        ),
      );
    } else if (type == FileType.video) {
      Future<Uint8List?>? uint8List;
      uint8List = VideoThumbnail.thumbnailData(video: _file.path);
      return FutureBuilder(
        future: uint8List,
        builder: (context, snaphot) => Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: margin),
          decoration: isForeground
              ? BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : null,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: snaphot.hasData
                ? snaphot.data != null
                    ? DecorationImage(
                        image: MemoryImage(snaphot.data!),
                        fit: BoxFit.cover,
                      )
                    : null
                : null,
          ),
          child: isForeground ? _foreground(borderRadius: borderRadius) : null,
        ),
      );
    } else if (type == FileType.photo) {
      return Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: margin),
        decoration: isForeground
            ? BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : null,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            colorFilter: const ColorFilter.mode(
              Color(0xfff4f0f3),
              BlendMode.dstOver,
            ),
            image: FileImage(_file as File),
            fit: BoxFit.cover,
          ),
        ),
        child: isForeground ? _foreground(borderRadius: borderRadius) : null,
      );
    } else if (isForeground && type != FileType.directory) {
      return Container(
        width: 240,
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: _foreground(borderRadius: borderRadius),
      );
    } else {
      return const SizedBox();
    }
  }

  Stack _foreground({required double borderRadius}) {
    return Stack(alignment: Alignment.center, children: [
      Positioned(
        right: -30,
        bottom: -40,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.white.withOpacity(0.2),
        ),
      ),
      Positioned(
        left: -20,
        top: -10,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.white.withOpacity(0.2),
        ),
      ),
      Positioned(
        right: 20,
        top: 10,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.white.withOpacity(0.2),
        ),
      ),
      Positioned(
        left: 15,
        bottom: 15,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.white.withOpacity(0.2),
        ),
      ),
      SvgPicture.asset(
        "assets/icons/${type == FileType.photo ? "image" : type == FileType.video ? "video" : type == FileType.audio ? 'audio' : "file"}.svg",
        colorFilter: const ColorFilter.mode(
          AppColors.white,
          BlendMode.srcIn,
        ),
        width: 80,
      ),
    ]);
  }
}
