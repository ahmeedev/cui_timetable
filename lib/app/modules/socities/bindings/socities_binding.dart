import 'package:get/get.dart';

import '../controllers/socities_controller.dart';

class SocitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocitiesController>(
      () => SocitiesController(),
    );
  }
}
