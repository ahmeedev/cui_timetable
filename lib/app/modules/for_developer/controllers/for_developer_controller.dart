import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:get/get.dart';

class ForDeveloperController extends GetxController {
  syncAllFiles() async {
    await Get.find<SyncController>().syncAllFiles();
  }
}
