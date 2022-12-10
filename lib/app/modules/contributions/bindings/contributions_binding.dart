import 'package:get/get.dart';

import '../controllers/contributions_controller.dart';

class ContributionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContributionsController>(
      () => ContributionsController(),
    );
  }
}
