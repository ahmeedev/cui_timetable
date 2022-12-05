import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  var isReports = false;
  var isAdminResponse = false;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  // late final future;
  Future<void> onInit() async {
    getReports();
    super.onInit();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getReports() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").doc(uid);
    if (docRef.snapshots().length == 0) {
      isReports = false;
    } else {
      isReports = true;
    }
    return docRef.snapshots();
  }


  Stream<DocumentSnapshot<Map<String, dynamic>>> getResponse() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").doc(uid);
    if (docRef.snapshots().length == 0) {
      isReports = false;
    } else {
      isReports = true;
    }
    return docRef.snapshots();
  }
}
