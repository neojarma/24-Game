import 'package:get/get.dart';

import 'controller.dart';

class OnlineModeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OnlineModeController>(OnlineModeController(), permanent: true);
  }
}
