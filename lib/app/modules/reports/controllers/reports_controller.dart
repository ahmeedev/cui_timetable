import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
   Future<void> onInit() async {
    super.onInit();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getReports() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("report").doc(uid);
    return docRef.snapshots();
  }

  deleteReport()
  {
    
  }
}
