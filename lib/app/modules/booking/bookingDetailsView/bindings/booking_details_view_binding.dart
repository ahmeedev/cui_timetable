import 'package:get/get.dart';

import '../controllers/booking_details_view_controller.dart';

class BookingDetailsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingDetailsViewController>(
      BookingDetailsViewController(),
    );
  }
}
