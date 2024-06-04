import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_app/core/class/file_inf.dart';

class AudioDialogController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  late FileInf file;
  @override
  void onInit() async {
    file = Get.arguments;
    await audioPlayer.setLoopMode(LoopMode.all);
    await audioPlayer.setAudioSource(ConcatenatingAudioSource(
      children: [AudioSource.file(file.path)],
    ));
    await audioPlayer.play();

    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
