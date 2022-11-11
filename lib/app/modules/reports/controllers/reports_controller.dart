import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  var isReports = false;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
}
