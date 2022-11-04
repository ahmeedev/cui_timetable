import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookingDetailsController extends GetxController {
  final bookingBy = Get.arguments['bookingBy'];
  final bookingFor = Get.arguments['bookingFor'];
  final bookingSlot = Get.arguments['bookingSlot'];

  final currentStep = 0.obs;

  book({required String section, required int time, required String room}) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("booking").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "${DateTime.now()}":{
        "section": section,
        "time": time,
        "room": room,
        "status":false,
      }
    }, SetOptions(merge: true)).onError((error, stackTrace) => GetXUtilities.snackbar(
        title: "Error!", message: error.toString(), gradient: errorGradient));
  }
}
