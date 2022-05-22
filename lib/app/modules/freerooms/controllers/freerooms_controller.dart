import 'package:get/get.dart';

class FreeroomsController extends GetxController {
  var mon = true.obs;
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

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
}
