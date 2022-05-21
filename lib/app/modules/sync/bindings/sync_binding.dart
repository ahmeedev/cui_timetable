import 'package:get/get.dart';

import '../controllers/sync_controller.dart';

class SyncBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyncController>(
      () => SyncController(),
    );
  }
}
