import 'package:get/get.dart';
import 'controller.dart';

class LobbyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LobbyController>(
      () => LobbyController(),
    );
  }
}
