import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/controllers/firebase/firebase_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DeveloperController extends GetxController {
  final firebase = Get.find<FirebaseController>();
  var sections = [].obs;
  var fireStorage = ''.obs;
  void retreive() async {
    final box = await Hive.openBox('info');
    final list = box.get('sections');
    if (list != null) {
      list.forEach((element) {
        sections.add(element);
      });
    }
  }
}
