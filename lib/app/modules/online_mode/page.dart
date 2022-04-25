import 'package:card_game/app/global_widgets/medium_custom_button.dart';
import 'package:card_game/app/global_widgets/small_custom_button.dart';
import 'package:card_game/app/modules/online_mode/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/text_theme.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';
import '../../data/enums/lobby_enums.dart';

class OnlineModePage extends GetView<OnlineModeController> {
  const OnlineModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
                'Set Name',
                textAlign: TextAlign.center,
                style: kTitlePageTextStyle.copyWith(
                  color: kSemiBlackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.usernameChangeStatus.value,
                    style: kHeading2TextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: kGreenColor,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textFieldController,
                      decoration: const InputDecoration(
                        hintText: 'Your Username',
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
                    title: 'Change Name',
                    color: kGreenColor,
                    function: controller.changeUsername,
                    textStyle: kHeading2TextStyle.copyWith(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              MediumCustomButton(
                color: kBackgroundGreenColor,
                title: 'Create Room',
                textStyle: kButtonTextStyle.copyWith(color: kLightGreenColor),
                function: () => controller.handleRedirectPage(Lobby.roomMaster),
              ),
              const SizedBox(
                height: 70,
                child: Center(child: Text('Or')),
              ),
              MediumCustomButton(
                color: Colors.white,
                title: 'Join Room',
                borderColor: kLightGreenColor,
                textStyle: kButtonTextStyle.copyWith(color: kLightGreenColor),
                function: () => controller.handleRedirectPage(Lobby.roomMember),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
