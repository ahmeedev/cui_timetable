import 'package:get/get.dart';

class FreeRoomsController extends GetxController {
  var mon = false.obs;
  var tue = true.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  void allFalse() {
    mon.value = false;
    tue.value = false;
    wed.value = false;
    thu.value = false;
    fri.value = false;
    print('executed');
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
