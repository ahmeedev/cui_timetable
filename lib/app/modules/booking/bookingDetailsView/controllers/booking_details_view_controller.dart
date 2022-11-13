import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';

class BookingDetailsViewController extends GetxController {
  final timestamp = Get.arguments['timestamp'];
  final section = Get.arguments['section'];
  final room = Get.arguments['room'];
  final slot = Get.arguments['slot'];
  var currentTimeSlots = [];
  var monToThursSlots = <String>[];
  var friSlots = <String>[];

  late final Future<void> future;
  @override
  void onInit() {
    future = initializeTimestamps();
    super.onInit();
  }

  // Make a global function for current time stamp.
  Future<void> initializeTimestamps() async {
    final boxx = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = await boxx.get(DBTimeSlots.monToThur);
    friSlots = await boxx.get(DBTimeSlots.fri);
    currentTimeSlots = monToThursSlots;
    return Future.value();
  }
}
