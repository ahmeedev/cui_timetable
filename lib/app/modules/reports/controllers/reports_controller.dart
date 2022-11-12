import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  var isReports = false;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
   late final future;
   Future<void> onInit() async {
    future = getReports();
    super.onInit();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getReports()  {
    isReports=true;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").doc(uid);
    return docRef.snapshots();
  }
}
