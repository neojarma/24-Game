import 'package:flutter/material.dart';
import '../core/theme/text_theme.dart';
import '../core/values/colors.dart';
import 'small_custom_button.dart';

class GameplayButton extends StatelessWidget {
  const GameplayButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmallCustomButton(
          title: 'Submit',
          color: kGreenColor,
          function: controller.handleUserAnswer,
          textStyle: kHeading2TextStyle.copyWith(color: Colors.white),
        ),
        const SizedBox(
          width: 30,
        ),
        SmallCustomButton(
          title: 'Clear',
          color: Colors.white,
          // color: kGreenColor,
          function: controller.reset,
          textStyle: kHeading2TextStyle.copyWith(color: kOrangeColor),
          borderColor: kOrangeColor,
        ),
      ],
    );
  }
}
