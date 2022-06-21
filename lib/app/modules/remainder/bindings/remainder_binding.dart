import 'package:cui_timetable/app/modules/remainder/controllers/student_ui_controlller.dart';
import 'package:cui_timetable/app/modules/remainder/controllers/teacher_ui_controller.dart';
import 'package:get/get.dart';

import '../controllers/remainder_controller.dart';

class RemainderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemainderController>(
      () => RemainderController(),
    );
    Get.lazyPut<StudentUIController>(
      () => StudentUIController(),
    );
    Get.lazyPut<TeacherUIController>(
      () => TeacherUIController(),
    );
  }
}
