import 'package:get/get.dart';

class BookingDetailsController extends GetxController {
  final bookingBy = Get.arguments['bookingBy'];
  final bookingFor = Get.arguments['bookingFor'];
  final bookingSlot = Get.arguments['bookingSlot'];

  final currentStep = 0.obs;
}
