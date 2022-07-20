import '../controllers/teacher_ui_controller.dart';
import 'package:get/get.dart';

import '../controllers/student_ui_controlller.dart';

import '../controllers/datesheet_controller.dart';

class DatesheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatesheetController>(
      () => DatesheetController(),
    );
    Get.lazyPut<DatesheetStudentUIController>(
      () => DatesheetStudentUIController(),
    );
    Get.lazyPut<DatesheetTeacherUIController>(
      () => DatesheetTeacherUIController(),
    );
  }
}
