import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/constant/app_colors.dart';

class PlayerAudioDialog extends StatelessWidget {
  const PlayerAudioDialog({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        PlayerState? playerState = snapshot.data;
        ProcessingState? processingState = playerState?.processingState;
        bool playing = playerState?.playing ?? false;
        return GestureDetector(
          onTap: () async {
            if (playing) {
              await audioPlayer.pause();
            } else if (processingState != ProcessingState.completed) {
              await audioPlayer.play();
            }
          },
          child: Icon(
            playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 20,
            color: AppColors.black,
          ),
        );
      },
    );
  }
}
