import 'package:get/get.dart';

import '../controllers/booking_info_controller.dart';

class BookingInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingInfoController>(
      BookingInfoController(),
    );
  }
}
