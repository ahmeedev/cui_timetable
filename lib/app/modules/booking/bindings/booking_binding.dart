import 'package:cui_timetable/app/modules/booking/controllers/booking_log_controller.dart';
import 'package:get/get.dart';

import '../controllers/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingController>(
      BookingController(),
    );
    Get.put<BookingLogController>(
      BookingLogController(),
    );
  }
}
