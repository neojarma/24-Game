import 'dart:math';
import 'package:card_game/app/core/values/strings.dart';
import 'package:card_game/app/data/models/player_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/enums/lobby_enums.dart';
import '../../routes/pages.dart';

class OnlineModeController extends GetxController {
  final textFieldController = TextEditingController();
  RxString usernameChangeStatus = ''.obs;
  // default username
  // late final String _generatedUsername;
  final maxUsernameLength = 10;

  Map<String, dynamic> arguments(Lobby lobby) {
    PlayerModel player =
        PlayerModel(id: generatePlayerId(), name: textFieldController.text);
    // argument to determine lobby status and username for the game
    return {'lobby': lobby, 'player': player};
  }

  void handleRedirectPage(Lobby lobby) {
    if (textFieldController.text.isEmpty) {
      usernameChangeStatus.value = invalidUsername;
      return;
    }
    Get.toNamed(
      Routes.LOBBY,
      arguments: arguments(lobby),
    );
  }

  String generatePlayerId() => (Random().nextInt(9000) + 1000).toString();

  void changeUsername() {
    final userInputUsername = textFieldController.text;
    if (userInputUsername.isEmpty) {
      usernameChangeStatus.value = invalidUsername;
      // close keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }

    // prevent user from inputting a lot of character for username
    if (userInputUsername.length > maxUsernameLength) {
      usernameChangeStatus.value = inputUsernameWarning;
      return;
    }

    // change username
    textFieldController.value = TextEditingValue(text: userInputUsername);
    usernameChangeStatus.value = acceptedUsername;
    // close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
