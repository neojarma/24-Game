import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/provider/firebase_firestore.dart';
import '../../routes/pages.dart';

class RematchController extends GetxController {
  final prevArgs = Get.arguments;

  late final String roomId;
  late final String currentPlayer;
  late final String opponent;
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> gameStream;

  @override
  void onInit() {
    assignValueFromArguments();

    super.onInit();
  }

  void assignValueFromArguments() {
    roomId = prevArgs['room_id'];
    opponent = prevArgs['opponent'];
    gameStream = prevArgs['stream'];
    currentPlayer = prevArgs['current_player'];
  }

  void redirectToMainPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 1500),
        () => Get.offNamedUntil(
          Routes.GAME_MODE,
          ModalRoute.withName(Routes.DASHBOARD),
        ),
      );
    });
  }

  void handleRematch() {
    // redirect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // update lobby information
      FirebaseProvider.rematch(roomId);

      Future.delayed(
          const Duration(seconds: 2),
          () => Get.offNamedUntil(
                Routes.ONLINE_GAMEPLAY,
                ModalRoute.withName(Routes.GAME_MODE),
                arguments: {
                  'room_id': roomId,
                  'opponent': opponent,
                  'current_player': currentPlayer,
                },
              ));
    });
  }
}
