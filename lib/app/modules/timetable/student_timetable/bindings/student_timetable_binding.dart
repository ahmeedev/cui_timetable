import 'package:get/get.dart';

import '../controllers/student_timetable_controller.dart';

// Package imports:

// Project imports:

class StudentTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentTimetableController>(
      () => StudentTimetableController(),
    );
  }
}
