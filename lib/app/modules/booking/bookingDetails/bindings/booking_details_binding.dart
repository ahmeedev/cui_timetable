import 'package:get/get.dart';

import '../controllers/booking_details_controller.dart';

class BookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingDetailsController>(
      BookingDetailsController(),
    );
  }
}
