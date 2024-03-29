import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/notification_topics.dart';
import '../../../../theme/app_constants.dart';

class SignInController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var isObscureText = true.obs;

  var emailTextController = TextEditingController();
  var passTextController = TextEditingController();

  // var respectedEmailSuffixes = [
  //   '@students.cuisahiwal.edu.pk',
  //   '@cuisahiwal.edu.pk',
  //   '@cuisahiwal.edu.pk'
  // ];

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

  cachePass() {
    if (isRemeberMe.value) {
      box!.put(DBAuthCache.signInPass, passTextController.text);
    } else {
      box!.delete(DBAuthCache.signInPass);
    }
  }

  final signInProgress = false.obs;
  signInUser({required String email, required String password}) async {
    signInProgress.value = true;
    try {
      log("SignIn in progress...", name: 'Google SignIn');

      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      log("SignIn in completed...", name: 'Google SignIn');

      if (firebaseAuth.currentUser!.emailVerified) {
        // muct be verified before signin
        log("Email Verified", name: 'Google SignIn');
        cachePass();
        box!.put(DBAuthCache.isSignIn, true);
        box!.put(
            DBAuthCache.sectionName,
            FirebaseAuth.instance.currentUser!.email!.substring(
                0, FirebaseAuth.instance.currentUser!.email!.indexOf('@')));

        //* register channels for notifications
        subscribeToRespectiveChannels();

        Get.back();
        Get.find<HomeController>().scaffoldKey.currentState!.openDrawer();
        Get.find<HomeController>().isUserSignIn.value = true;
        log("User sign in with Token ${FirebaseAuth.instance.currentUser!.uid}",
            name: 'SignIn');
        GetXUtilities.snackbar(
            title: 'Sign In',
            message: 'Sign in successfully!',
            gradient: successGradient);
      } else {
        Get.find<AuthenticationController>()
            .infoMsg
            .add('In order to proceed, Verify the email first.');

        GetXUtilities.snackbar(
            duration: 3,
            title: "Auth!",
            message: "A verification email is sent, check your inbox.",
            gradient: successGradient);
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
            message: "Password is incorrect",
            gradient: errorGradient);
      } else if (e.code == 'invalid-email') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Error!",
            message: "Email formatting is incorrect.",
            gradient: errorGradient);
      } else if (e.code == 'user-disabled') {
        GetXUtilities.snackbar(
            duration: 3,
            title: "Error!",
            message: "Email formatting is incorrect.",
            gradient: errorGradient);
      }
    } catch (e) {
      GetXUtilities.snackbar(
          duration: 3,
          title: "Error!",
          message: e.toString(),
          gradient: errorGradient);
    } finally {
      signInProgress.value = false;
    }
  }

  var forgetPassEmailController = TextEditingController();
  final forgetPassProgress = false.obs;
  forgetPassDialog() {
    final theme = Theme.of(Get.context!);

    Get.defaultDialog(
        backgroundColor: onScaffoldColor,
        title: 'Forget Password',
        titleStyle: theme.textTheme.titleMedium!
            .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        content: Column(children: [
          TextFormField(
              controller: forgetPassEmailController,
              // onSaved: (value) {},

              style: Theme.of(Get.context!)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // fillColor: selectionColor,
                hintText: "Enter your email",
                // suffixText: '@students.cuisahiwal.edu.pk',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            Get.find<AuthenticationController>()
                                    .respectedEmailSuffixes[
                                Get.find<AuthenticationController>()
                                    .segmentedControlGroupValue
                                    .value],
                            style: theme.textTheme.labelMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),

                prefixIcon: const Icon(
                  Icons.email,
                  color: primaryColor,
                ),
                // focusColor: Colors.red,
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius),
                    borderSide:
                        const BorderSide(color: primaryColor, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius),
                    borderSide:
                        const BorderSide(color: primaryColor, width: 2)),
              )),
          kHeight,
          Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: forgetPassProgress.value
                    ? const SpinKitFadingCircle(
                        key: ValueKey(5),
                        size: 50,
                        color: primaryColor,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (forgetPassEmailController.text.isEmpty) {
                            GetXUtilities.snackbar(
                                duration: 3,
                                title: "Error!",
                                message: "Email is empty",
                                gradient: errorGradient);
                            return;
                          }
                          forgetPassProgress.value = true;
                          try {
                            final email = forgetPassEmailController.text +
                                Get.find<AuthenticationController>()
                                        .respectedEmailSuffixes[
                                    Get.find<AuthenticationController>()
                                        .segmentedControlGroupValue
                                        .value];
                            log("Email: $email", name: 'Forget Password');
                            await firebaseAuth.sendPasswordResetEmail(
                                email: email);
                            Get.back();
                            GetXUtilities.snackbar(
                                duration: 3,
                                title: "Email sent!",
                                message:
                                    "A recovery email is sent in your inbox.",
                                gradient: successGradient);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              GetXUtilities.snackbar(
                                  duration: 3,
                                  title: "Error!",
                                  message: "Email formatting is incorrect.",
                                  gradient: errorGradient);
                            } else if (e.code == 'user-not-found') {
                              GetXUtilities.snackbar(
                                  duration: 3,
                                  title: "Auth!",
                                  message:
                                      "User with this email is not found. Register yourself",
                                  gradient: errorGradient);
                            }
                          } catch (e) {
                            GetXUtilities.snackbar(
                                duration: 3,
                                title: "Error!",
                                message: e.toString(),
                                gradient: errorGradient);
                          } finally {
                            // signInProgress.value = false;
                            forgetPassProgress.value = false;
                          }
                        },
                        child: const Text("Send Email").paddingSymmetric(
                            horizontal: Constants.defaultPadding * 2,
                            vertical: Constants.defaultPadding * 1.5)),
              ))
        ]));
  }

  subscribeToRespectiveChannels() async {
    //? subscribe everyone to their uid tokens, for the purpose of notifying them indiviually.
    FirebaseMessaging.instance
        .subscribeToTopic(FirebaseAuth.instance.currentUser!.uid);
    FirebaseMessaging.instance.subscribeToTopic(everyoneTopic);

    if (Get.find<AuthenticationController>().segmentedControlGroupValue.value ==
        0) {
      // * storing details for the device.
      await FirebaseFirestore.instance
          .collection('info')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"tag": "student"});
      FirebaseMessaging.instance.subscribeToTopic(studentTopic);
      log("Subscribing to Student topic", name: "Cloud Messaging");
    } else if (Get.find<AuthenticationController>()
            .segmentedControlGroupValue
            .value ==
        1) {
      await FirebaseFirestore.instance
          .collection('info')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"tag": "teacher"});
      FirebaseMessaging.instance.subscribeToTopic(teacherTopic);
      log("Subscribing to Teacher topic", name: "Cloud Messaging");
    } else if (Get.find<AuthenticationController>()
            .segmentedControlGroupValue
            .value ==
        2) {
      FirebaseMessaging.instance.subscribeToTopic(adminTopic);
      log("Subscribing to admin topic", name: "Cloud Messaging");
    }
    // Get.find<AuthenticationController>().subscribeToChannel('students');
  }

  Future<UserCredential> signInWithGoogle() async {
    signInProgress.value = true;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    // print(credential);
    signInProgress.value = false;
    log('SignIn Successfully with email ${googleUser!.email}',
        name: 'AuthController');
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  googleSignOut() async {
    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      GetXUtilities.snackbar(
          title: 'Error!!',
          message: "Sign out Unsuccessfully",
          gradient: errorGradient);
    }
  }
}
