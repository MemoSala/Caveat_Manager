import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/message_dialog_controller.dart';
import '../../core/constant/app_colors.dart';
import '../widgets/message_dialog/button_message_dialog.dart';

class MessageDialogRename extends StatelessWidget {
  const MessageDialogRename({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final Future<void> Function(String newName) onPressed;
  @override
  Widget build(BuildContext context) {
    Get.put(MessageDialogController());
    return Center(
      child: Container(
        height: 200,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: AppColors.white,
        ),
        child: GetBuilder<MessageDialogController>(builder: (controller) {
          controller.editNameFile(text);
          if (!controller.isLoading) {
            return Form(
              key: controller.static,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 15),
                  Material(
                    child: TextFormField(
                      controller: controller.nameFile,
                      validator: (value) {
                        if (value == "") {
                          return "error 404";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Rename",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
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
                          var formdata = controller.static.currentState;
                          if (formdata!.validate()) {
                            controller.loading();
                            await onPressed(controller.nameFile.text).then(
                              (value) => Get.back(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
