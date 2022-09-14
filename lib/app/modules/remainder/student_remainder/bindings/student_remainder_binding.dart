import 'package:get/get.dart';

import '../controllers/student_remainder_controller.dart';

class StudentRemainderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentRemainderController>(
      StudentRemainderController(),
    );
  }
}
