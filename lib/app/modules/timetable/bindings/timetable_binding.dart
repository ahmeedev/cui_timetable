import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/timetable/controllers/student_ui_controller.dart';
import 'package:cui_timetable/app/modules/timetable/controllers/teacher_ui_controller.dart';

import '../controllers/timetable_controller.dart';

// Package imports:

// Project imports:

class TimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherUIController>(
      () => TeacherUIController(),
    );
    Get.lazyPut<StudentUIController>(
      () => StudentUIController(),
    );
    Get.lazyPut<TimetableController>(
      () => TimetableController(),
    );
  }
}
