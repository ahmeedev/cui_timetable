import 'package:get/get.dart';

import '../controllers/teacher_datesheet_controller.dart';

class TeacherDatesheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDatesheetController>(
      () => TeacherDatesheetController(),
    );
  }
}
