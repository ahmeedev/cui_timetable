import 'package:get/get.dart';

import '../controllers/sec_sec_controller.dart';

class SecSecBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SecSecController>(
      SecSecController(),
    );
  }
}
