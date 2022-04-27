import 'dart:async';

import 'package:card_game/app/data/provider/api_card_provider.dart';
import 'package:card_game/app/data/provider/api_game_solution.dart';
import 'package:card_game/app/data/provider/firebase_firestore.dart';
import 'package:card_game/app/routes/pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/strings.dart';

class ResultController extends GetxController {
  final Map<String, dynamic> prevPageArgs = Get.arguments;

  late final bool isWinning;
  late final String timeFinish;
  late final String currentPlayer;
  late final String opponent;

  int currentPlayerScore = 0;
  int opponentScore = 0;
  late String roomId;

  var backStatus = ''.obs;

  bool isRematch = false;

  @override
  void onInit() {
    assignVariableFromArgument();

    FirebaseProvider.clearRematch(roomId, currentPlayer, opponent);

    super.onInit();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchRematch() {
    return FirebaseProvider.gameStream(roomId);
  }

  void assignVariableFromArgument() {
    isWinning = prevPageArgs['is_winning'];
    timeFinish = prevPageArgs['finish_time'];
    currentPlayer = prevPageArgs['current_player'];
    opponent = prevPageArgs['opponent'];
    roomId = prevPageArgs['room_id'];

    if (isWinning) {
      currentPlayerScore = 1;
    } else {
      opponentScore = 1;
    }
  }

  void backToGameModeScreen() {
    backStatus.value = 'Redirecting';
    FirebaseProvider.playerLeftRematch(roomId, currentPlayer);
    Future.delayed(
      const Duration(seconds: 1),
      () => Get.offNamedUntil(
        Routes.GAME_MODE,
        ModalRoute.withName(Routes.DASHBOARD),
      ),
    );
  }

  Future<bool> handleOnWillPop() async {
    Get.defaultDialog<bool>(
      title: exitDialogTitle,
      middleText: exitConfirmation,
      textConfirm: dialogConfirm,
      confirmTextColor: Colors.white,
      textCancel: dialogCancel,
      onConfirm: backToGameModeScreen,
    );
    return false;
  }

  void playerReadyToRematch() async {
    isRematch = true;

    Get.offNamedUntil(Routes.REMATCH, ModalRoute.withName(Routes.GAME_MODE),
        arguments: {
          'room_id': roomId,
          'opponent': opponent,
          'current_player': currentPlayer,
          'stream': watchRematch(),
        });

    // request deck
    var deck = await CardProvider.getDeck(4);
    List<int> numbers = [];
    for (var element in deck.listOfCards) {
      numbers.add(element['value']);
    }

    var solution = await SolutionProvider.getSolution(numbers);
    if (!solution.solution) {
      handleRematch();
    }
    var newCards = deck.listOfCards;

    // add ready player status
    FirebaseProvider.playerReadyToRematch(roomId, currentPlayer, newCards);
  }

  void handleRematch() async {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    FirebaseProvider.playerReadyToRematch(roomId, currentPlayer, null);
    FirebaseProvider.rematch(roomId);

    // redirect to gameplay again
    Future.delayed(const Duration(seconds: 2), () {
      return Get.offNamedUntil(
        Routes.ONLINE_GAMEPLAY,
        ModalRoute.withName(Routes.GAME_MODE),
        arguments: {
          'room_id': roomId,
          'opponent': opponent,
          'current_player': currentPlayer,
        },
      );
    });
  }
}
