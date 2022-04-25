import 'package:card_game/app/core/theme/text_theme.dart';
import 'package:card_game/app/core/values/assets.dart';
import 'package:card_game/app/core/values/colors.dart';
import 'package:card_game/app/core/values/strings.dart';
import 'package:card_game/app/modules/lobby/controller.dart';
import 'package:card_game/app/modules/lobby/widget/opponent_found.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MasterLobby extends GetView<LobbyController> {
  const MasterLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleOnWillPopMaster,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(miniIcon),
              SizedBox(
                height: Get.height / 10,
              ),
              Text(
                'Battle With Friends',
                style: kTitlePageTextStyle.copyWith(color: Colors.pink),
              ),
              SizedBox(
                height: Get.height / 10,
              ),
              Obx(
                () => Text(
                  controller.opponentFound.value,
                  style: kHeading3TextStyle,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Room ID ${controller.roomId}',
                    style: kHeading3TextStyle.copyWith(
                      color: kLightGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Image.asset(extraMiniIcon),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: controller.watchOpponent(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  try {
                    String? opponent =
                        snapshot.data!.get('player_two_username');

                    if (opponent != null) {
                      controller.changeOpponenFoundValue(opponentFound);
                      String currentPlayer =
                          snapshot.data!.get('player_one_username');
                      return OpponentFound(
                        snapdata: opponent,
                        function: () =>
                            controller.startGame(opponent, currentPlayer),
                      );
                    }
                  } catch (e) {
                    controller.changeOpponenFoundValue(opponentNotFound);
                    return const SpinKitThreeBounce(
                      color: kSemiBlackColor,
                      size: 15,
                    );
                  }

                  return const Text('waiting...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
