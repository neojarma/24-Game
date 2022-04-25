import 'package:get/get.dart';

import 'controller.dart';

class WaitingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingController>(
      () => WaitingController(),
    );
  }
}
