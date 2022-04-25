import 'package:flutter/material.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/medium_custom_button.dart';

class OpponentFound extends StatelessWidget {
  const OpponentFound({
    Key? key,
    required this.snapdata,
    required this.function,
  }) : super(key: key);

  final String snapdata;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Found',
          style: kHeading3TextStyle.copyWith(fontSize: 15),
        ),
        Text(
          'Your Opponent',
          style: kHeading3TextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          snapdata,
          style: kHeading3TextStyle.copyWith(color: kLightGrey),
        ),
        const SizedBox(
          height: 10,
        ),
        MediumCustomButton(
          title: 'Start Game',
          color: kLightGreenColor,
          function: function,
          textStyle: kButtonTextStyle,
        ),
      ],
    );
  }
}
