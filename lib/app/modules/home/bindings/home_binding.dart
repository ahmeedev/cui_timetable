import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SyncController>(
      () => SyncController(),
    );
  }
}
