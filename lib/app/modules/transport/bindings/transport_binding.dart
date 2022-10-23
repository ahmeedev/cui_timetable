import 'package:get/get.dart';

import '../controllers/transport_controller.dart';

class TransportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransportController>(
      () => TransportController(),
    );
  }
}
