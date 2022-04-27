import 'package:get/get.dart';
import 'controller.dart';

class RematchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RematchController>(
      () => RematchController(),
    );
  }
}
