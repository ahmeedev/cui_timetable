import 'package:get/get.dart';

import '../controllers/portals_controller.dart';

class PortalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PortalsController>(
      PortalsController(),
    );
  }
}
