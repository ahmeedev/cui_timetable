import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminFeedbackController extends GetxController {
  //TODO: Implement AdminFeedbackController

  final count = 0.obs;
  final isResponded=false;
  @override
  void onInit() {
    super.onInit();
  }

 getReports()  {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").snapshots();
    return docRef;
  }

 sendResponse()
 {
  print("Inside response method");
 }

}
