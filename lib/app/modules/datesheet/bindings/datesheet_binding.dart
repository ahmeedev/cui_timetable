import 'package:get/get.dart';

import '../controllers/datesheet_controller.dart';

class DatesheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatesheetController>(
      () => DatesheetController(),
    );
  }
}
