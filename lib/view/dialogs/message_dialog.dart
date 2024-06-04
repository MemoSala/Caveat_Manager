import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/message_dialog_controller.dart';
import '../../core/constant/app_colors.dart';
import '../widgets/message_dialog/button_message_dialog.dart';
import '../widgets/message_dialog/text_message_dialog.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.text, required this.onPressed});
  final String text;
  final Future<void> Function() onPressed;
  @override
  Widget build(BuildContext context) {
    Get.put(MessageDialogController());
    return Center(
      child: Container(
        height: 150,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: AppColors.white,
        ),
        child: GetBuilder<MessageDialogController>(builder: (controller) {
          if (!controller.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                TextMessageDialog(text: text),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonMessageDialog(
                      text: "No",
                      onPressed: Get.back,
                    ),
                    ButtonMessageDialog(
                      text: "Yes",
                      onPressed: () async {
                        controller.loading();
                        await onPressed().then((value) => Get.back());
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
