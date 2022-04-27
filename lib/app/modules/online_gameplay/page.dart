import 'package:card_game/app/core/values/colors.dart';
import 'package:card_game/app/core/values/strings.dart';
import 'package:card_game/app/global_widgets/game_bar_widget.dart';
import 'package:card_game/app/global_widgets/loading_widget.dart';
import 'package:card_game/app/modules/online_gameplay/widget/opponent_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/text_theme.dart';
import '../../global_widgets/cards_grid.dart';
import '../../global_widgets/result_box.dart';
import '../../global_widgets/user_answer_section.dart';
import 'controller.dart';

class OnlineGameplayPage extends GetView<OnlineGameplayController> {
  const OnlineGameplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleOnWillPop,
      child: Scaffold(
        body: SafeArea(
          child: controller.obx(
            (state) => StreamBuilder<DocumentSnapshot>(
              stream: controller.gameStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  final snapdata = snapshot.data?.get('game_status');
                  if (snapdata != 'start') {
                    final winner = snapshot.data?.get('winner');
                    controller.redirectToResultScreen(winner);
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Battle Mode',
                      style: kTitlePageTextStyle.copyWith(color: kPinkColor),
                    ),
                    GameBar(
                      titleGameMode: fourCardMode,
                      controller: controller,
                      widget:
                          OpponentBox(opponentName: controller.opponentName),
                    ),
                    ResultBox(controller: controller),
                    CardsGrid(
                      controller: controller,
                      gridCount: 2,
                      cards: controller.cards,
                    ),
                    UserAnswerWidget(controller: controller),
                  ],
                );
              },
            ),
            onLoading: const LoadingWidget(),
            onError: (string) => const Text('failed to fetch data : ('),
          ),
        ),
      ),
    );
  }
}
