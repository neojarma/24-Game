import 'package:get/get.dart';
import 'controller.dart';

class SolverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SolverController>(() => SolverController());
  }
}
