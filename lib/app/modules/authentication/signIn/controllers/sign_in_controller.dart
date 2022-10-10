import 'dart:developer';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var isObscureText = true.obs;

  addNewUser({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseAuth.currentUser!.sendEmailVerification();
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
    }
  }

  signInUser({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (firebaseAuth.currentUser!.emailVerified) {
        log("Email Verified");
      } else {
        log("Email Not Verified");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Error!",
            message: e.message.toString(),
            gradient: errorGradient);
      } else if (e.code == 'wrong-password') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Error!",
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
