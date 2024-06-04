import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/audio_dialog_controller.dart';
import '../../core/constant/app_colors.dart';
import '../widgets/audio_dialog/photo_audio_dialog.dart';
import '../widgets/audio_dialog/player_audio_dialog.dart';
import '../widgets/audio_dialog/position_audio_dialog.dart';
import '../widgets/audio_dialog/title_audio_dialog.dart';

class AudioDialog extends StatelessWidget {
  const AudioDialog({super.key});

  @override
  Widget build(BuildContext context) {
    AudioDialogController controller = Get.put(AudioDialogController());
    return Center(
      child: Container(
        height: 80,
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(children: [
          if (controller.file.metd != null)
            PhotoAudioDialog(metd: controller.file.metd!),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    PlayerAudioDialog(audioPlayer: controller.audioPlayer),
                    const SizedBox(width: 10),
                    TitleAudioDialog(title: controller.file.name),
                  ]),
                ),
                PositionAudioDialog(audioPlayer: controller.audioPlayer),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
