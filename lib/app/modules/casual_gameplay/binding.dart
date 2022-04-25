import 'package:get/get.dart';

import 'controller.dart';

class GameplayBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameplayController>(() => GameplayController());
  }
}
