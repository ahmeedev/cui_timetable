import 'package:get/get.dart';

import '../controllers/cancel_booking_controller.dart';

class CancelBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelBookingController>(
      () => CancelBookingController(),
    );
  }
}
