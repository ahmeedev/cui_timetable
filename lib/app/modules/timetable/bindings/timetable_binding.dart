import 'package:get/get.dart';

import '../controllers/comparison_ui_controller.dart';
import '../controllers/student_ui_controller.dart';
import '../controllers/teacher_ui_controller.dart';

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
