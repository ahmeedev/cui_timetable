import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/constants/firebase_constants.dart';
import 'package:cui_timetable/app/modules/booking/bookingDetails/controllers/booking_details_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingRoomController extends GetxController {
  // final bookedRoomsList = <String>[].obs;
  late final Future<List<String>> roomsFuture;

  @override
  void onInit() {
    roomsFuture = calculateBookedRooms();
    super.onInit();
  }

  Future<List<String>> calculateBookedRooms() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection(bookingCollection).doc(bookedRooms);
    final response = await docRef.get();
    final data = Map<String, dynamic>.from(response.data() ?? {});
    final date = DateFormat.yMd()
        .format(Get.find<BookingDetailsController>().bookingDate)
        .replaceAll("/", "-");
    final tag = "$date-${Get.find<BookingDetailsController>().bookingSlot}";

    List<String> result = List<String>.from(data[tag] ?? []);
    return Future.value(result);
  }
}
