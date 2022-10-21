import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/authentication_controller.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPassController = TextEditingController();
  var firebaseAuth = FirebaseAuth.instance;
  var isObscureText = true.obs;

  // var respectedEmailSuffixes = [
  //   '@gmail.com',
  //   '@gmadasdfsadfil.com',
  //   '@gmail.com'
  // ];
  final signUpProgress = false.obs;
  signUpUser({required String email, required String password}) async {
    signUpProgress.value = true;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firebaseAuth.currentUser!.sendEmailVerification();
      Get.find<AuthenticationController>().isSignIn.value = true;
      Get.find<AuthenticationController>()
          .infoMsg
          .add('A verification email is sent at $email, Check your inbox');

      GetXUtilities.snackbar(
          title: "Sign Up",
          duration: 3,
          message:
              'Account created Successfully!!, Check your email for verification',
          gradient: successGradient);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Error!",
            message: e.message.toString(),
            gradient: errorGradient);
      } else if (e.code == 'email-already-in-use') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Error!",
            message: e.message.toString(),
            gradient: errorGradient);
      }
    } catch (e) {
      GetXUtilities.snackbar(
          title: "Error!", message: e.toString(), gradient: errorGradient);
    } finally {
      signUpProgress.value = false;
    }
  }
}
