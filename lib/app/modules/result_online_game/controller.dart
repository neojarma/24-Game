import 'package:card_game/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  final Map<String, dynamic> prevPageArgs = Get.arguments;
  late final bool isWinning;
  late final String timeFinish;

  @override
  void onInit() {
    isWinning = prevPageArgs['is_winning'];
    timeFinish = prevPageArgs['finish_time'];
    super.onInit();
  }

  void backToGameModeScreen() {
    Get.offNamedUntil(Routes.GAME_MODE, ModalRoute.withName(Routes.DASHBOARD));
  }
}
