import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/theme/text_theme.dart';
import '../../core/values/assets.dart';
import 'controller.dart';

class RematchPage extends GetView<RematchController> {
  const RematchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 30,
            ),
            Image.asset(miniIcon),
            SizedBox(
              height: Get.height / 10,
            ),
            Text(
              'Rematch',
              style: kTitlePageTextStyle.copyWith(color: Colors.pink),
            ),
            SizedBox(
              height: Get.height / 10,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: controller.gameStream,
              builder: (context, snapshot) {
                var snapdata = snapshot.data;

                try {
                  String opponentStatus = snapdata?.get(controller.opponent);

                  if (opponentStatus == 'left') {
                    controller.redirectToMainPage();
                    return opponentLeftRoom();
                  }

                  controller.handleRematch();
                  return Text(
                    'Rematch !!',
                    style: kHeading3TextStyle,
                  );
                } catch (err) {
                  return waitingForOpponent();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Column waitingForOpponent() {
    return Column(
      children: [
        Text(
          'Waiting for opponent response',
          style: kHeading3TextStyle,
        ),
        const SizedBox(
          height: 15,
        ),
        const SpinKitThreeBounce(
          size: 20,
          color: Colors.black,
        ),
      ],
    );
  }

  Column opponentLeftRoom() {
    return Column(
      children: [
        Text(
          'Your Opponent Has Left The Room',
          style: kHeading3TextStyle,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Redirecting to Main Page',
          style: kHeading2TextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        const SpinKitThreeBounce(
          size: 20,
          color: Colors.black,
        ),
      ],
    );
  }
}
