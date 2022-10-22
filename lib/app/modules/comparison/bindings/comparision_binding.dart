import 'package:cui_timetable/app/modules/comparison/controllers/teac_sect_view_controller.dart';
import 'package:get/get.dart';

import '../controllers/comparison_controller.dart';
import '../controllers/sect_sect_view_controller.dart';

class ComparisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComparisonController>(
      () => ComparisonController(),
    );

    Get.lazyPut<SectSectViewController>(
      () => SectSectViewController(),
    );

    Get.lazyPut<TeacSetViewController>(
      () => TeacSetViewController(),
    );
  }
}
