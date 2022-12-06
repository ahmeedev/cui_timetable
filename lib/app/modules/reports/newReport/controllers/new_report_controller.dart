import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewReportController extends GetxController {
  final TextEditingController titleControler = TextEditingController();
  final TextEditingController descripControler = TextEditingController();

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  void uploadData(String title, String description, DateTime userTimestamp) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").doc(uid);

    docRef
        .set({
          "${DateTime.now()}": {
            "userTitle": titleControler.text,
            "userMsg": descripControler.text,
            "adminTitle":"Response",
            "adminTime": "",
            "adminMsg":""
          },
        }, SetOptions(merge: true))
        .onError((error, stackTrace) => GetXUtilities.snackbar(
            title: "Error", message: error.toString(), gradient: errorGradient))
        .then((value) {
          GetXUtilities.snackbar(
              title: "Feedback Added",
              message: "Your feedback was added successfuly",
              gradient: primaryGradient);
              titleControler.clear();
              descripControler.clear();
        });
  }
}
