import 'package:get/get.dart';

import '../controllers/new_report_controller.dart';

class NewReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewReportController>(
      () => NewReportController(),
    );
  }
}
