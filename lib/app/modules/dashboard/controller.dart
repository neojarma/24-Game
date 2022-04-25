import 'package:card_game/app/routes/pages.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  void handlePage() {
    Get.toNamed(Routes.GAME_MODE);
  }
}
