import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/datesheet/controllers/student_ui_controlller.dart';

import '../controllers/datesheet_controller.dart';

class DatesheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatesheetController>(
      () => DatesheetController(),
    );
    Get.lazyPut<StudentUIController>(
      () => StudentUIController(),
    );
  }
}
