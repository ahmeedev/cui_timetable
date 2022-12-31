import 'package:get/get.dart';

import '../controllers/booking_date_controller.dart';

class BookingDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDateController>(
      () => BookingDateController(),
    );
  }
}
