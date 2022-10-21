import 'package:get/get.dart';

import '../controllers/for_developer_controller.dart';

class ForDeveloperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForDeveloperController>(
      () => ForDeveloperController(),
    );
  }
}
