// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../controllers/student_timetable_controller.dart';

class StudentTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentTimetableController>(
      () => StudentTimetableController(),
    );
  }
}
