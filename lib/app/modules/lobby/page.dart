import 'package:card_game/app/modules/lobby/widget/builder.dart';
import 'package:flutter/material.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LobbyBuilder(),
    );
  }
}
