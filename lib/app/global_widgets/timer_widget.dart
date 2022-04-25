import 'package:card_game/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key, required this.controller}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: controller.timerStream,
      initialData: 0,
      builder: (context, snapshot) {
        final value = snapshot.data!;

        final displayTime = StopWatchTimer.getDisplayTime(
          value,
          hours: false,
          milliSecond: false,
          minute: true,
        );

        controller.setTime = value;

        return Column(
          children: [
            Text(
              'Time',
              style: kHeading2TextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              displayTime,
            ),
          ],
        );
      },
    );
  }
}
