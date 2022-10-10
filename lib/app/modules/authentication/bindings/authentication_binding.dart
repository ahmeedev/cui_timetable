import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';
import '../signIn/controllers/sign_in_controller.dart';
import '../signUp/controllers/sign_up_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );

    Get.lazyPut<SignInController>(
      () => SignInController(),
    );

    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
