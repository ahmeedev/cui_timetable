import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentTimetableController extends GetxController {
  late final box;
  var mon = true.obs; // mon is selected by default
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var daywiseLectures = [].obs;

  var monLectures = [];
  var tueLectures = [];
  var wedLectures = [];
  var thuLectures = [];
  var friLectures = [];
  var lecturesCount = <String, String>{}.obs;

  openBox({required section}) async* {
    box = await Hive.openBox(section);
    final list = box.values;
    await _setLectures(list: list, key: "10000");
    await _setLectures(list: list, key: "1000");
    await _setLectures(list: list, key: "100");
    await _setLectures(list: list, key: "10");
    await _setLectures(list: list, key: "1");

    daywiseLectures.value = monLectures; //* For default purpose

    yield lecturesCount;
  }

  void allFalse() {
    mon.value = false;
    tue.value = false;
    wed.value = false;
    thu.value = false;
    fri.value = false;
  }

  giveValue(index) {
    if (index == 0) {
      return mon;
    } else if (index == 1) {
      return tue;
    } else if (index == 2) {
      return wed;
    } else if (index == 3) {
      return thu;
    } else {
      return fri;
    }
  }

  _setLectures({required list, required String key}) {
    if (key == "10000") {
      monLectures = list.where((element) => element[2] == key).toList();
      monLectures.sort((a, b) => a[1].compareTo(b[1]));
      lecturesCount[key] = monLectures.length.toString();
    } else if (key == "1000") {
      tueLectures = list.where((element) => element[2] == key).toList();
      tueLectures.sort((a, b) => a[1].compareTo(b[1]));
      lecturesCount[key] = tueLectures.length.toString();
    } else if (key == "100") {
      wedLectures = list.where((element) => element[2] == key).toList();
      wedLectures.sort((a, b) => a[1].compareTo(b[1]));
      lecturesCount[key] = wedLectures.length.toString();
    } else if (key == "10") {
      thuLectures = list.where((element) => element[2] == key).toList();
      thuLectures.sort((a, b) => a[1].compareTo(b[1]));
      lecturesCount[key] = thuLectures.length.toString();
    } else if (key == "1") {
      friLectures = list.where((element) => element[2] == key).toList();
      friLectures.sort((a, b) => a[1].compareTo(b[1]));
      lecturesCount[key] = friLectures.length.toString();
    }
  }

  void getLectures({required String key}) {
    if (key == "10000") {
      daywiseLectures.value = monLectures;
    } else if (key == "1000") {
      daywiseLectures.value = tueLectures;
    } else if (key == "100") {
      daywiseLectures.value = wedLectures;
    } else if (key == "10") {
      daywiseLectures.value = thuLectures;
    } else if (key == "1") {
      daywiseLectures.value = friLectures;
    }
  }
}
