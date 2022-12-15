import 'package:get/get.dart';

import '../controllers/booking_approval_controller.dart';

class BookingApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingApprovalController>(
      () => BookingApprovalController(),
    );
  }
}
