import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentUIController extends GetxController {
  var sections;

  // @override
  // void onInit() {
  //   fetchSections();
  //   super.onInit();
  // }

  Future<void> fetchSections() async {
    final box = await Hive.openBox('info');
    final list = box.get('sections');
    sections = list;
  }
}
