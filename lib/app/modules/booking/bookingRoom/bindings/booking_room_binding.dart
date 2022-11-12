import 'package:get/get.dart';

import '../controllers/booking_room_controller.dart';

class BookingRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingRoomController>(
      BookingRoomController(),
    );
  }
}
