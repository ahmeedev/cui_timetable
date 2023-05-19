
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/models/report_model.dart';
import 'package:get/get.dart';

class AdminFeedbackController extends GetxController {
  final count = 0.obs;
  final isResponded = false;
  final reports = Report();
  final results = <String, dynamic>{};
  final keys = [];

  FirebaseFirestore db = FirebaseFirestore.instance;
  getReports() {
    final docRef = db.collection("report").snapshots();
    docRef.forEach((element) {
      var docs = element.docs;
      for (var e in docs) {
        reports.documentId = e.id;
        final map = e.data();
        keys.sort((a, b) {
          //sorting in ascending order
          return DateTime.parse(b).compareTo(DateTime.parse(a));
        });
        map.forEach((key, value) {
          // log(value.toString());
          results[key] = value;
          reports.feedbacks.add(Feedback(
              key, results[key]["userTitle"], results[key]["userMsg"]));
        });
        for (var key in map.keys) {
          keys.add(key);
        }
      }
      // log(keys.toString());
    });
    return docRef;
  }

  deleteReport({required Map results, required List keys, required int index}) {
    // final docRef = db.collection("report").doc();

    // log(keys[index].toString());
  }
}
