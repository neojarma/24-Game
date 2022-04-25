import 'package:card_game/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key, required this.controller}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: (controller.userAnswerStatus == '')
            ? null
            : Center(
                child: Text(
                  controller.userAnswerStatus,
                  style:
                      kHeading2TextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
      ),
    );
  }
}
