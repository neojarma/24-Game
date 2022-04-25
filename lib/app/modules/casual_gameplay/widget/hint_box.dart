import 'package:card_game/app/core/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';

class HintBox extends GetView<GameplayController> {
  const HintBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Get.defaultDialog(
            title: 'Possible Solution',
            middleText: '${controller.deck.equation} = 24'),
        child: Image.asset(solutionIcon),
      ),
    );
  }
}
