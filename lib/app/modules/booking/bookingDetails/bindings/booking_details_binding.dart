import 'package:cui_timetable/app/modules/freerooms/controllers/freerooms_controller.dart';
import 'package:get/get.dart';

import '../controllers/booking_details_controller.dart';

class BookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingDetailsController>(
      BookingDetailsController(),
    );

    Get.put<FreeroomsController>(
      FreeroomsController(),
    );
  }
}
