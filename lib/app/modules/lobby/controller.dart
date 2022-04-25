// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';
import 'package:card_game/app/core/values/strings.dart';
import 'package:card_game/app/data/enums/lobby_enums.dart';
import 'package:card_game/app/data/models/player_model.dart';
import 'package:card_game/app/data/provider/api_card_provider.dart';
import 'package:card_game/app/data/provider/api_game_solution.dart';
import 'package:card_game/app/data/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/pages.dart';

class LobbyController extends GetxController {
  final previousPageArguments = Get.arguments;
  late final Lobby lobby;
  late String roomId;
  late final PlayerModel player;
  final textFieldController = TextEditingController();
  RxString roomStatus = ''.obs;
  RxString opponentFound = opponentNotFound.obs;

  @override
  void onInit() {
    lobby = previousPageArguments['lobby'];
    player = previousPageArguments['player'];

    roomId = generateRoomId();
    // only generate room id if it's room master
    if (lobby == Lobby.roomMaster) {
      createLobby();
    }

    super.onInit();
  }

  Future<bool> handleOnWillPopMaster() async {
    Get.defaultDialog<bool>(
      title: exitDialogTitle,
      middleText: exitRoomWarning,
      textConfirm: dialogConfirm,
      textCancel: dialogCancel,
      confirmTextColor: Colors.white,
      onConfirm: handleExitRoomMaster,
    );
    return false;
  }

  void changeOpponenFoundValue(String status) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      opponentFound.value = status;
    });
  }

  void handleExitRoomMaster() {
    Get.offNamedUntil(Routes.ONLINE, ModalRoute.withName(Routes.GAME_MODE));

    // delete player 2
    FirebaseProvider.deleteRoomById(roomId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchOpponent() {
    return FirebaseProvider.gameStream(roomId);
  }

  void startGame(String opponent, String currentPlayer) {
    FirebaseProvider.startGame(roomId, player);

    Get.toNamed(
      Routes.ONLINE_GAMEPLAY,
      arguments: {
        'room_id': roomId,
        'opponent': opponent,
        'current_player': currentPlayer
      },
    );
  }

  void redirectPage() {
    Get.toNamed(Routes.WAITING, arguments: roomId);
  }

  void createLobby() async {
    final deck = await CardProvider.getDeck(4);
    final cards = deck.listOfCards;

    // get all value from cards
    List<int> numbers = [];
    cards.forEach((card) {
      numbers.add(card['value']);
    });

    // check solution
    final solution = await SolutionProvider.getSolution(numbers);

    if (solution.solution) {
      FirebaseProvider.createLobby(roomId, player, cards);
      return;
    }

    createLobby();
  }

  String generateRoomId() {
    return (Random().nextInt(9000) + 1000).toString();
  }

  void findRoomId() async {
    String id = textFieldController.text;
    if (id.length != 4) {
      roomStatus.value = invalidRoomId;
      return;
    }

    bool isRoomExist = await FirebaseProvider.findRoomById(id);

    if (isRoomExist) {
      FocusManager.instance.primaryFocus?.unfocus();
      // add player to lobby
      FirebaseProvider.addPlayerToLobby(id, player);
      // gameStatus.value = true;
      roomId = textFieldController.text;

      redirectPage();

      // clear state
      roomStatus.value = '';
      textFieldController.clear();
      return;
    }

    roomStatus.value = roomNotFound;
    textFieldController.clear();
  }
}
