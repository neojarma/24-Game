import 'package:card_game/app/global_widgets/timer_widget.dart';
import 'package:flutter/material.dart';

import '../core/theme/text_theme.dart';

class GameBar extends StatelessWidget {
  const GameBar(
      {Key? key,
      required this.controller,
      required this.widget,
      required this.titleGameMode})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final Widget widget;
  final String titleGameMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TimerWidget(controller: controller)),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                titleGameMode,
                style: kHeading2TextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(child: widget),
        ],
      ),
    );
  }
}
