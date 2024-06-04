import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../core/class/file_inf.dart';
import '../../core/constant/app_colors.dart';

class VideoDialog extends StatefulWidget {
  const VideoDialog({super.key, required this.file});
  final FileInf file;

  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  late VideoPlayerController controller;
  bool isTape = true, isSmoil = true, isVolumeOn = true;

  void initStateFuture() async {
    controller = VideoPlayerController.file(File(widget.file.path))
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..setVolume(100)
      ..initialize().then((vol) {});
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  @override
  void initState() {
    super.initState();
    initStateFuture();
  }

  void disposeFuture() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    disposeFuture();
    closeVideo();
  }

  void ranVideo() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  String _timeVideo(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    return [
      if (controller.value.duration.inHours > 0) twoDigits(position.inHours),
      twoDigits(position.inMinutes.remainder(60)),
      twoDigits(position.inSeconds.remainder(60)),
    ].join(":");
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Container(
            color: AppColors.black,
            child: Column(children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: ranVideo,
                        onDoubleTap: () {
                          if (isTape) {
                            openVideo(value.size);
                          } else {
                            closeVideo();
                          }
                          setState(() => isTape = !isTape);
                        },
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (isTape)
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(children: [
                          const SizedBox(width: 10),
                          Text(
                            _timeVideo(value.position),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              inherit: false,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 5,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: VideoProgressIndicator(
                                  controller,
                                  allowScrubbing: true,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _timeVideo(controller.value.duration),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              inherit: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() => isVolumeOn = !isVolumeOn);
                                controller.setVolume(isVolumeOn ? 100 : 0);
                              },
                              iconSize: 40,
                              color: Colors.white,
                              icon: Icon(
                                isVolumeOn
                                    ? Icons.volume_up_outlined
                                    : Icons.volume_off_outlined,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.seekTo(
                                value.position - const Duration(seconds: 10),
                              ),
                              iconSize: 40,
                              color: Colors.white,
                              icon: const Icon(Icons.fast_rewind_outlined),
                            ),
                            IconButton(
                              onPressed: ranVideo,
                              iconSize: 40,
                              color: Colors.white,
                              icon: Icon(
                                controller.value.isPlaying
                                    ? Icons.pause_outlined
                                    : Icons.play_arrow_outlined,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.seekTo(
                                value.position + const Duration(seconds: 10),
                              ),
                              iconSize: 40,
                              color: Colors.white,
                              icon: const Icon(Icons.fast_forward_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() => isTape = false);
                                openVideo(value.size);
                              },
                              iconSize: 40,
                              color: Colors.white,
                              icon: Icon(
                                isSmoil
                                    ? Icons.fullscreen_outlined
                                    : Icons.fullscreen_exit_outlined,
                              ),
                            ),
                          ],
                        ),
                      ]);
                    },
                  ),
                ),
            ]),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Future openVideo(Size size) async {
    if (size.height > size.width) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  Future closeVideo() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
