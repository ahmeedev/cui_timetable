import 'package:get/get.dart';

import '../controllers/comparison_controller.dart';

class ComparisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComparisonController>(
      () => ComparisonController(),
    );
  }
}
