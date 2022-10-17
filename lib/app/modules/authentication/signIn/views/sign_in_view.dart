import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          kHeight,
          kHeight,
          TextFormField(
              controller: controller.emailTextController,
              // onSaved: (value) {},
              onChanged: (value) {
                controller.box!.put(DBAuthCache.signInEmail, value);
              },
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // fillColor: textFieldColor,
                hintText: "Enter your email",
                // suffixText: '@students.cuisahiwal.edu.pk',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            controller.respectedEmailSuffixes[
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
          kHeight,
          Obx(() => TextFormField(
              // onChanged: (value) {
              //   if (controller.isRemeberMe.value) {
              //     controller.box!.put(DBAuthCache.signInPass, value);
              //   } else {
              //     controller.box!.delete(DBAuthCache.signInPass);
              //   }
              // },
              controller: controller.passTextController,
              obscureText: controller.isObscureText.value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // focusColor: Colors.green,
                // suffixText: 'KG',

                hintText: "Enter your passsword",

                // filled: true,
                prefixIcon: const Icon(
                  Icons.password,
                  color: primaryColor,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isObscureText.value =
                        !controller.isObscureText.value;
                  },
                  child: controller.isObscureText.value
                      ? const Icon(
                          // FontAwesomeIcons.eyeLowVision,
                          FontAwesomeIcons.eye,
                          color: primaryColor,
                        )
                      : const Icon(
                          // FontAwesomeIcons.eyeLowVision,
                          FontAwesomeIcons.eyeLowVision,
                          color: primaryColor,
                        ),
                ),

                // iconColor: Colors.grey,

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
              ))),
          kHeight,
          kHeight,
          Row(
            children: [
              Text("Remember me",
                  textAlign: TextAlign.right,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                  )).paddingOnly(left: 4),
              Obx(() => Checkbox(
                    visualDensity: VisualDensity.compact,
                    splashRadius: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Constants.defaultRadius / 2))),
                    value: controller.isRemeberMe.value,
                    onChanged: (value) {
                      controller.isRemeberMe.value =
                          !controller.isRemeberMe.value;

                      controller.box!.put(DBAuthCache.isRememberSignIn, value);
                    },
                    fillColor: MaterialStateProperty.all(primaryColor),
                  )),
              const Spacer(),
              InkWell(
                onTap: () {
                  controller.forgetPassDialog();
                  // controller.forgetPassword();
                },
                child: Text(
                  "Forget Password?",
                  textAlign: TextAlign.right,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          kHeight,
          kHeight,
          Obx(
            () => AnimatedSwitcher(
                layoutBuilder: (currentChild, previousChildren) =>
                    currentChild!,
                transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                duration: const Duration(milliseconds: 200),
                child: controller.signInProgress.value == false
                    ? ClipRRect(
                        key: const ValueKey(6),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Constants.defaultRadius)),
                        child: ElevatedButton(
                            onPressed: () {
                              // controller.addNewUser(
                              //     email: "inahmee77@gmail.com", password: 'aspire');
                              Get.find<AuthenticationController>()
                                  .infoMsg
                                  .clear();
                              if (controller.emailTextController.text.isEmpty) {
                                GetXUtilities.snackbar(
                                    title: "Error!",
                                    message: 'Invalid Email',
                                    gradient: errorGradient);
                              } else if (controller
                                  .passTextController.text.isEmpty) {
                                GetXUtilities.snackbar(
                                    title: "Error!",
                                    message: 'Password is empty!',
                                    gradient: errorGradient);
                              } else {
                                controller.signInUser(
                                    email: controller.emailTextController.text,
                                    password:
                                        controller.passTextController.text);
                              }
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.all(Constants.defaultPadding * 2),
                              child: Text('Sign In',
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            )),
                      )
                    : const SpinKitFadingCircle(
                        key: ValueKey(5),
                        size: 50,
                        color: primaryColor,
                      )),
          ),
          kHeight,
          kHeight,
          kHeight,
          kHeight,
          Text(
            "Or, SIGN IN WITH...",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.black),
          ),
          kHeight,
          kHeight,
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                // foregroundColor:
                //     MaterialStateProperty.all(Colors.blue),
                side: MaterialStateProperty.all(const BorderSide(
                    color: primaryColor, width: 2.0, style: BorderStyle.solid)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius))),
              ),
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding), // 16.0
                child: Icon(
                  Icons.facebook,
                  color: Colors.blue,
                  size: Constants.iconSize,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                await controller.signInWithGoogle().then((value) =>
                    Get.find<HomeController>().isUserSignIn.value = true);
                Get.back();
                GetXUtilities.snackbar(
                    title: 'Sign in',
                    message: 'Sign in successfully!',
                    gradient: successGradient);
              },
              style: ButtonStyle(
                // foregroundColor:
                //     MaterialStateProperty.all(Colors.blue),
                side: MaterialStateProperty.all(const BorderSide(
                    color: primaryColor, width: 2.0, style: BorderStyle.solid)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius))),
              ),
              // child: Padding(
              //   padding: EdgeInsets.all(
              //       Constants.defaultPadding), // 16.0
              //   child: Icon(
              //     FontAwesomeIcons.google,
              //     color: Colors.red,
              //     size: Constants.iconSize,
              //   ),
              // ),
              child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Image.asset(
                    'assets/sign_in/google.png',
                    width: Constants.iconSize,
                  )),
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                // foregroundColor:
                //     MaterialStateProperty.all(Colors.blue),
                side: MaterialStateProperty.all(const BorderSide(
                    color: primaryColor, width: 2.0, style: BorderStyle.solid)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius))),
              ),
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding), // 16
                child: Icon(
                  FontAwesomeIcons.github,
                  color: Colors.black,
                  size: Constants.iconSize,
                ),
              ),
            ),
          ]),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New, to CUI SAHIWAL?  ",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),

              // const Spacer(),
              InkWell(
                onTap: () {
                  Get.find<AuthenticationController>().isSignIn.value =
                      !Get.find<AuthenticationController>().isSignIn.value;
                },
                child: Container(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Text(
                    // "Register yourself",
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }
}
