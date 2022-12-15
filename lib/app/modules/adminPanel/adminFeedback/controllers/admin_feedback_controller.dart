import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminFeedbackController extends GetxController {
  //TODO: Implement AdminFeedbackController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

 getReports()  {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").get();
    return docRef;
  }

}
