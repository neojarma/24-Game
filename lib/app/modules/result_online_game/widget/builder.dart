import 'package:card_game/app/core/theme/text_theme.dart';
import 'package:card_game/app/core/values/assets.dart';
import 'package:card_game/app/core/values/colors.dart';
import 'package:card_game/app/core/values/strings.dart';
import 'package:card_game/app/global_widgets/medium_custom_button.dart';
import 'package:card_game/app/modules/result_online_game/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultBuilder extends GetView<ResultController> {
  const ResultBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleOnWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    (controller.isWinning) ? winTitle : loseTitle,
                    style: kTitlePageTextStyle.copyWith(color: kPinkColor),
                  ),
                ),
              ),
              Text(
                (controller.isWinning) ? winDesc : loseDesc,
                style: kHeading2TextStyle.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height / 10,
              ),
              Image.asset((controller.isWinning) ? emojiWin : emojiLose),
              SizedBox(
                height: Get.height / 10,
              ),
              Text(
                'Finish Time',
                style: kHeading3TextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                controller.timeFinish,
                style: kHeading2TextStyle.copyWith(
                    color: kLightGrey, fontSize: 25),
              ),
              SizedBox(
                height: Get.height / 10,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: controller.watchRematch(),
                builder: (context, snapshot) {
                  var snapdata = snapshot.data;

                  try {
                    // get opponent status property
                    final String opponentStatus =
                        snapdata!.get(controller.opponent);

                    if (opponentStatus == 'rematch') {
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Get.defaultDialog(
                          barrierDismissible: false,
                          title: rematchTitle,
                          middleText: rematchDesc,
                          textConfirm: dialogConfirm,
                          textCancel: dialogCancel,
                          confirmTextColor: Colors.white,
                          onConfirm: controller.handleRematch,
                          onCancel: controller.backToGameModeScreen,
                          onWillPop: () async => false,
                        );
                      });
                    }
                  } catch (err) {
                    return MediumCustomButton(
                      title: 'Rematch',
                      color: kGreenColor,
                      function: controller.playerReadyToRematch,
                      textStyle: kButtonTextStyle,
                    );
                  }

                  return MediumCustomButton(
                    title: 'Rematch',
                    color: kGreenColor,
                    function: controller.playerReadyToRematch,
                    textStyle: kButtonTextStyle,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MediumCustomButton(
                title: 'Quit Game',
                color: Colors.white,
                function: controller.backToGameModeScreen,
                textStyle: kButtonTextStyle.copyWith(color: kOrangeColor),
                borderColor: kOrangeColor,
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Text(
                  controller.backStatus.value,
                  style: kHeading2TextStyle.copyWith(color: kOrangeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
