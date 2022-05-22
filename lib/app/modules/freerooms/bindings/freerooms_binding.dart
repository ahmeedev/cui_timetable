import 'package:get/get.dart';

import '../controllers/freerooms_controller.dart';

class FreeroomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeroomsController>(
      () => FreeroomsController(),
    );
  }
}
