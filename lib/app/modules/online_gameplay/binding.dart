import 'package:get/get.dart';

import 'controller.dart';

class OnlineGameplayBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineGameplayController>(
      () => OnlineGameplayController(),
    );
  }
}
