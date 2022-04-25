import 'package:get/get.dart';

import 'controller.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(
      () => ResultController(),
    );
  }
}
