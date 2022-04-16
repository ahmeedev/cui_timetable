import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StartUpController extends GetxController {
  var sections = [].obs;

  Future<void> fetchSections() async {
    final box = await Hive.openBox('info');
    final list = box.get('sections');
    // print(list);
    if (list != null) {
      list.forEach((element) {
        sections.add(element);
      });
    }
  }
}
