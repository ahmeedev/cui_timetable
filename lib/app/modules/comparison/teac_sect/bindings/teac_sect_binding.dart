import 'package:get/get.dart';

import '../controllers/teac_sect_controller.dart';

class TeacSectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacSectController>(
      () => TeacSectController(),
    );
  }
}
