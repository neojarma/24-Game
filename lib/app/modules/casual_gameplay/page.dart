import 'package:card_game/app/core/theme/text_theme.dart';
import 'package:card_game/app/global_widgets/game_bar_widget.dart';
import 'package:card_game/app/modules/casual_gameplay/widget/hint_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_widgets/loading_widget.dart';
import 'controller.dart';
import '../../global_widgets/cards_grid.dart';
import '../../global_widgets/result_box.dart';
import '../../global_widgets/user_answer_section.dart';

class GameplayPage extends GetView<GameplayController> {
  const GameplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleOnWillPop,
      child: Scaffold(
        body: SafeArea(
          child: controller.obx(
            (state) => Column(
              children: [
                Text(
                  'Casual Mode',
                  style: kTitlePageTextStyle,
                ),
                GameBar(
                  controller: controller,
                  widget: const HintBox(),
                  titleGameMode: controller.titleGameMode,
                ),
                ResultBox(controller: controller),
                CardsGrid(
                  gridCount: controller.gridCount,
                  controller: controller,
                  cards: controller.deck.cardModel!.listOfCards,
                ),
                UserAnswerWidget(controller: controller),
              ],
            ),
            onLoading: const LoadingWidget(),
            onError: (string) => const Text('failed to fetch data : ('),
          ),
        ),
      ),
    );
  }
}
