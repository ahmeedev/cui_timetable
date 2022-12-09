import 'package:cui_timetable/app/data/database/rooms_location.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var roomsKeys = [];
  @override
  void onInit() {
    roomsKeys = roomsLocation.keys.toList();
    super.onInit();
    // authCache = await Hive.openBox(DBNames.authCache);
  }
}
