import 'package:get/get.dart';

import '../controllers/admin_notifications_controller.dart';

class AdminNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminNotificationsController>(
      AdminNotificationsController(),
    );
  }
}
