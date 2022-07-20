import '../controllers/student_ui_controlller.dart';
import '../controllers/teacher_ui_controller.dart';
import 'package:get/get.dart';

import '../controllers/remainder_controller.dart';

class RemainderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemainderController>(
      () => RemainderController(),
    );
    Get.lazyPut<RemainderStudentUIController>(
      () => RemainderStudentUIController(),
    );
    Get.lazyPut<RemainderTeacherUIController>(
      () => RemainderTeacherUIController(),
    );
  }
}
