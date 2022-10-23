import 'package:get/get.dart';

import '../controllers/teac_teac_controller.dart';

class TeacTeacBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacTeacController>(
      () => TeacTeacController(),
    );
  }
}
