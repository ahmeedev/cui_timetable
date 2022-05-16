import 'package:get/get.dart';

import '../controllers/teacher_timetable_controller.dart';

class TeacherTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherTimetableController>(
      () => TeacherTimetableController(),
    );
  }
}