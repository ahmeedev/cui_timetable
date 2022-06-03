import 'package:get/get.dart';

import '../controllers/freerooms_controller.dart';

// Package imports:

// Project imports:

class FreeroomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeroomsController>(
      () => FreeroomsController(),
    );
  }
}
