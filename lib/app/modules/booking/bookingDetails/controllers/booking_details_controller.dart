import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/utilities/notifications/cloud_notifications.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingDetailsController extends GetxController {
  final bookingBy = Get.arguments['bookingBy'];
  final bookingFor = Get.arguments['bookingFor'];
  final bookingDay = Get.arguments['bookingDay'];
  final bookingSlot = Get.arguments['bookingSlot'];
  var bookingRoom = ""
      .obs; //* Came from the freerooms module, on the onTap of the freeroom card.

  final timeMap = {
    "1": "Monday",
    "2": "Tuesday",
    "3": "Wednesday",
    "4": "Thursday",
    "5": "Friday",
  };

  final currentStep = 0.obs;
  final notificationSent = false.obs;

  late final bookingDate;

  late final Future<String> bookingDateFuture;
  @override
  void onInit() {
    bookingDateFuture = calculateDate();
    super.onInit();
  }

  Future<String> calculateDate() {
    // print(bookingDay);
    var startDate = DateTime.now();
    if (startDate.weekday == bookingDay) {
      startDate = startDate.add(const Duration(days: 1));
    }
    final nextDate = startDate.add(Duration(
      days: (bookingDay - startDate.weekday) % DateTime.daysPerWeek,
    ));
    bookingDate = nextDate;
    final result = DateFormat.MMMMEEEEd().format(nextDate).toString();

    return Future.value(result);
  }

  book(
      {required String section,
      required int time,
      required String room}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("booking")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "${DateTime.now()}": {
        "section": section,
        "time": time,
        "room": room,
        "status": false,
      }
    }, SetOptions(merge: true)).onError((error, stackTrace) =>
            GetXUtilities.snackbar(
                title: "Error!",
                message: error.toString(),
                gradient: errorGradient));

    await sendNotification(
      title: 'Room Booked',
      description:
          "Booked for $bookingFor by $bookingFor at slot $bookingSlot in room C1 is done.",
    ).then((value) => notificationSent.value = true);
  }
}
