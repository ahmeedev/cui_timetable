import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminNotificationsController extends GetxController {
  late Stream<DocumentSnapshot> stream;

  @override
  void onInit() {
    stream = getNotificationsFromFirebase();
    super.onInit();
  }

  Stream<DocumentSnapshot> getNotificationsFromFirebase() {
    final db = FirebaseFirestore.instance;
    return db.collection('admin').doc('notifications').snapshots();
  }
}
