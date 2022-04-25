import 'package:card_game/app/data/enums/lobby_enums.dart';
import 'package:card_game/app/modules/lobby/controller.dart';
import 'package:card_game/app/modules/lobby/widget/master_lobby.dart';
import 'package:card_game/app/modules/lobby/widget/member_lobby.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LobbyBuilder extends GetView<LobbyController> {
  const LobbyBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller.lobby == Lobby.roomMaster)
        ? const MasterLobby()
        : const MemberLobby();
  }
}
