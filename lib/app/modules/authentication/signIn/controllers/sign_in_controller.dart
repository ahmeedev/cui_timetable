import 'dart:developer';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SignInController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var isObscureText = true.obs;

  var emailTextController = TextEditingController();
  var passTextController = TextEditingController();

  var respectedEmailSuffixes = [
    '@students.cuisahiwal.edu.pk',
    '@cuisahiwal.edu.pk',
    '@cuisahiwal.edu.pk'
  ];

  var isRemeberMe = false.obs;
  Box? box;
  @override
  Future<void> onInit() async {
    box = await Hive.openBox(DBNames.authCache);
    emailTextController.text =
        box!.get(DBAuthCache.signInEmail, defaultValue: '');
    passTextController.text =
        box!.get(DBAuthCache.signInPass, defaultValue: '');

    isRemeberMe.value =
        box!.get(DBAuthCache.isRememberSignIn, defaultValue: false);
    super.onInit();
  }

  signInUser({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (firebaseAuth.currentUser!.emailVerified) {
        log("Email Verified");
        //login logic here
      } else {
        Get.find<AuthenticationController>()
            .infoMsg
            .add('A verification email is sent. check your inbox');

        print(Get.find<AuthenticationController>().infoMsg);
        // GetXUtilities.snackbar(
        //     duration: 3,
        //     title: "Auth!",
        //     message: "A verification email is sent, check your inbox.",
        //     gradient: successGradient);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Auth!",
            message: "User with this email is not found. Register yourself",
            gradient: errorGradient);
      } else if (e.code == 'wrong-password') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Auth!",
            message: e.message.toString(),
            gradient: errorGradient);
      }
    } catch (e) {
      GetXUtilities.snackbar(
          duration: 3,
          title: "Error!",
          message: e.toString(),
          gradient: errorGradient);
    }
  }
}
