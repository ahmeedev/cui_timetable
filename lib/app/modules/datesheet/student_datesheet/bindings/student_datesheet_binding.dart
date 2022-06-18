import 'package:get/get.dart';

import '../controllers/student_datesheet_controller.dart';

class StudentDatesheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDatesheetController>(
      () => StudentDatesheetController(),
    );
  }
}
