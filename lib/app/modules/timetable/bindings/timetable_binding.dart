import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/timetable/controllers/comparison_ui_controller.dart';
import 'package:cui_timetable/app/modules/timetable/controllers/student_ui_controller.dart';
import 'package:cui_timetable/app/modules/timetable/controllers/teacher_ui_controller.dart';

class TimetableBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TimetableController>(
    //   () => TimetableController(),
    // );
    Get.lazyPut<StudentUIController>(
      () => StudentUIController(),
    );
    Get.lazyPut<TeacherUIController>(
      () => TeacherUIController(),
    );
    Get.lazyPut<ComparisonUiController>(
      () => ComparisonUiController(),
    );
  }
}
