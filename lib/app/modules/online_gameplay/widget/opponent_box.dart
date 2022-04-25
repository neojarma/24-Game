import 'package:card_game/app/modules/online_gameplay/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/text_theme.dart';

class OpponentBox extends GetView<OnlineGameplayController> {
  const OpponentBox({Key? key, required this.opponentName}) : super(key: key);

  final String opponentName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'VS',
          style: kHeading2TextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(opponentName)
      ],
    );
  }
}
