import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/constants/firebase_constants.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/notifications/cloud_notifications.dart';

class BookingDetailsController extends GetxController {
  final bookingBy = Get.arguments['bookingBy'];
  final bookingFor = Get.arguments['bookingFor'];
  final bookingDay = Get.arguments['bookingDay'];
  final bookingSlot = Get.arguments['bookingSlot'];
  var bookingRoom = ""
      .obs; //* Came from the freerooms module, on the onTap of the freeroom card.
  late final bookingDate;

  final timeMap = {
    "1": "Monday",
    "2": "Tuesday",
    "3": "Wednesday",
    "4": "Thursday",
    "5": "Friday",
  };

  final currentStep = 0.obs;
  final isRoomAvailable = true.obs;
  final notificationSent = false.obs;
  final isBookingSuccessful = true.obs;

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
      required int slot,
      required String room}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    //? Check the freerooms here.
    final docRef = db.collection(bookingCollection).doc(bookedRooms);
    final response = await docRef.get();
    final date = DateFormat.yMd()
        .format(Get.find<BookingDetailsController>().bookingDate)
        .replaceAll("/", "-");
    final tag = "$date-${Get.find<BookingDetailsController>().bookingSlot}";

    List<String> result;
    if (response.data() == null) {
      result = [];
    } else {
      result = List<String>.from(response.data()![tag] ?? []);
    }
    if (!result.contains(bookingRoom.value)) {
      db.runTransaction((transaction) async {
        final now = DateTime.now();
        final uid = FirebaseAuth.instance.currentUser!.uid;

        await db.collection(bookingCollection).doc(bookedRooms).update({
          tag: FieldValue.arrayUnion([bookingRoom.value.toString()]),
        });

        await db.collection(bookingCollection).doc(uid).set({
          "$now": {
            "section": section,
            "slot": slot,
            "room": room,
            "date": bookingDate.toString(),
            "status": true,
          }
        }, SetOptions(merge: true)).onError((error, stackTrace) =>
            GetXUtilities.snackbar(
                title: "Error!",
                message: error.toString(),
                gradient: errorGradient));

        final bookingLog =
            "Booking with $bookingFor in room ${bookingRoom.value} at slot $bookingSlot on $date";

        await db.collection(bookingCollection).doc(bookingsLog).set({
          uid: {
            "$now": bookingLog,
          }
        }, SetOptions(merge: true)).onError((error, stackTrace) =>
            GetXUtilities.snackbar(
                title: "Error!",
                message: error.toString(),
                gradient: errorGradient));
      }).then(
        (value) => log("DocumentSnapshot successfully updated!"),
        onError: (e) => log("Error updating document $e", name: 'ERROR'),
      );
    } else {
      isRoomAvailable.value = false;
      notificationSent.value = false;
      isBookingSuccessful.value = false;
      GetXUtilities.snackbar(
          duration: 3,
          title: "Error!",
          message: "Room is already booked, make another selection",
          gradient: errorGradient);
    }

    if (isBookingSuccessful.value) {
      await sendNotification(
        title: 'Room Booked!',
        description:
            "$bookingBy make booking for $bookingFor at room ${bookingRoom.value} for ${DateFormat.yMMMMd().format(bookingDate)} in slot $bookingSlot.",
      ).then((value) => notificationSent.value = true);
    }
  }
}
