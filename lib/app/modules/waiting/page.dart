import 'package:card_game/app/modules/waiting/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../core/theme/text_theme.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';

class WaitingPage extends GetView<WaitingController> {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleOnWillPopMember,
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
              Text(
                'Waiting for Room Master',
                style: kHeading3TextStyle,
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
                stream: controller.stream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.data?.exists == false) {
                    controller.handleRoomDeleted();
                    return Column(
                      children: [
                        Text(
                          'Room is deleted',
                          style: kHeading3TextStyle,
                        ),
                        Text(
                          'Redirecting',
                          style: kHeading3TextStyle.copyWith(color: kLightGrey),
                        ),
                        const SpinKitThreeBounce(
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    );
                  }

                  try {
                    var gameStatus = snapshot.data?.get('game_status');

                    if (gameStatus != null) {
                      var opponent = snapshot.data!.get('player_one_username');
                      var currentPlayer =
                          snapshot.data!.get('player_two_username');
                      controller.redirectToGameplay(opponent, currentPlayer);

                      return Text(
                        'Game started',
                        style: kHeading3TextStyle,
                      );
                    }
                  } catch (e) {
                    var opponent = snapshot.data?.get('player_one_username');
                    return Column(
                      children: [
                        Text(
                          'Your Opponent',
                          style: kHeading3TextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          opponent,
                          style: kHeading3TextStyle.copyWith(color: kLightGrey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SpinKitThreeBounce(
                          color: Colors.black,
                          size: 20,
                        )
                      ],
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
