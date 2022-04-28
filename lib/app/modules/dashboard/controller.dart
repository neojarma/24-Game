import 'package:card_game/app/routes/pages.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  void gameModePage() {
    Get.toNamed(Routes.GAME_MODE);
  }

  void solverPage() {
    Get.toNamed(Routes.SOLVER);
  }
}
