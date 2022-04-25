import 'package:card_game/app/modules/lobby/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/small_custom_button.dart';

class MemberLobby extends GetView<LobbyController> {
  const MemberLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(miniIcon),
              SizedBox(
                height: Get.height / 8,
              ),
              Text(
                'Input Room ID',
                textAlign: TextAlign.center,
                style: kTitlePageTextStyle.copyWith(
                  color: kSemiBlackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textFieldController,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Room ID',
                        counterText: '',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kLightGreenColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SmallCustomButton(
                    title: 'Join',
                    color: kGreenColor,
                    function: controller.findRoomId,
                    textStyle: kHeading2TextStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Text(
                  controller.roomStatus.value,
                  style: kHeading2TextStyle.copyWith(color: kPinkColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
