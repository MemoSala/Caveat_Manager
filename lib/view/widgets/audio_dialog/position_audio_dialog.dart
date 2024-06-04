import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx;

import '../../../core/class/position_data.dart';
import '../../../core/constant/app_colors.dart';

class PositionAudioDialog extends StatelessWidget {
  const PositionAudioDialog({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            PositionData? positionData = snapshot.data;
            return ProgressBar(
              barHeight: 8,
              timeLabelTextStyle: const TextStyle(
                color: AppColors.black,
              ),
              progress: positionData?.position ?? Duration.zero,
              buffered: positionData?.buffered ?? Duration.zero,
              total: positionData?.duration ?? Duration.zero,
              onSeek: audioPlayer.seek,
            );
          },
        ),
      ),
    );
  }

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, buffered, duration) => PositionData(
          position: position,
          buffered: buffered,
          duration: duration ?? Duration.zero,
        ),
      );
}
