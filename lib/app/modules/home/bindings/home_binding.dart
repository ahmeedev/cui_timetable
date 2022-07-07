import 'package:cui_timetable/app/modules/settings/controllers/settings_controller.dart';
import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    ////! bcz, dynamic theme computation are earlier than building this screen. that's why it is necassary to put this controller here.
    // Get.put<HomeController>(
    //   HomeController(),
    // );
    Get.put<SyncController>(
      SyncController(),
    );
    // Get.put<SettingsController>(
    //   SettingsController(),
    // );
  }
}
