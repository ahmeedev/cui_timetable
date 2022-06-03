import 'package:get/get.dart';

import '../controllers/teacher_timetable_controller.dart';

// Package imports:

// Project imports:

class TeacherTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherTimetableController>(
      () => TeacherTimetableController(),
    );
  }
}
