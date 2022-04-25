import 'package:card_game/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'gameplay_button.dart';
import 'operator_builder.dart';

class UserAnswerWidget extends StatelessWidget {
  const UserAnswerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Your Answer',
            style: kHeading2TextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Obx(() => Text(
                controller.getUserAnswer(),
                style: kHeading2TextStyle.copyWith(color: Colors.black54),
              )),
          const SizedBox(
            height: 20,
          ),
          OperatorBuilder(controller: controller),
          const SizedBox(
            height: 20,
          ),
          GameplayButton(controller: controller),
        ],
      ),
    );
  }
}
