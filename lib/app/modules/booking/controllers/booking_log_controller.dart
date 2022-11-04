import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookingLogController extends GetxController {

  late final future;
  @override
  Future<void> onInit() async {
    future=getLogs();
    super.onInit();
  }


  Future<DocumentSnapshot<Map<String, dynamic>>> getLogs(){
    final uid=FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("booking").doc(uid);

    return docRef.get();
  }




}
