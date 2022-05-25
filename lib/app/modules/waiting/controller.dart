import 'package:card_game/app/data/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/strings.dart';
import '../../routes/pages.dart';

class WaitingController extends GetxController {
  final roomId = Get.arguments;

  Stream<DocumentSnapshot<Map<String, dynamic>>> stream() {
    return FirebaseProvider.gameStream(roomId);
  }

  void redirectToGameplay(String opponent, String currentPlayer) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Get.toNamed(
        Routes.ONLINE_GAMEPLAY,
        arguments: {
          'room_id': roomId,
          'opponent': opponent,
          'current_player': currentPlayer
        },
      ),
    );
  }

  void handleRoomDeleted() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAndToNamed(
            Routes.ONLINE,
          );
        });
      },
    );
  }

  Future<bool> handleOnWillPopMember() async {
    Get.defaultDialog<bool>(
      title: exitDialogTitle,
      middleText: exitRoomWarning,
      textConfirm: dialogConfirm,
      textCancel: dialogCancel,
      confirmTextColor: Colors.white,
      onConfirm: handleExitRoomMember,
    );
    return false;
  }

  void handleExitRoomMember() {
    Get.offNamedUntil(Routes.ONLINE, ModalRoute.withName(Routes.GAME_MODE));

    // delete room lobby
    FirebaseProvider.leftLobby(roomId);
  }
}
