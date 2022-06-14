import 'package:get/get.dart';

import '../controllers/comparision_controller.dart';

class ComparisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComparisionController>(
      () => ComparisionController(),
    );
  }
}
