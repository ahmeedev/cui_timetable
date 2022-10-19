import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import '../../controllers/authentication_controller.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
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
              controller: controller.emailController,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // isDense: true,
                // suffixIconConstraints: BoxConstraints.tight(const Size(60, 3)),
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
              controller: controller.passwordController,
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
                // suffixIcon: const Icon(
                //   FontAwesomeIcons.eyeLowVision,
                //   color: primaryColor,
                // ),

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
          Obx(() => TextFormField(
              controller: controller.cPassController,
              obscureText: controller.isObscureText.value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // focusColor: Colors.green,
                // suffixText: 'KG',

                hintText: "Confirm your passsword",

                // filled: true,
                prefixIcon: const Icon(
                  Icons.password,
                  color: primaryColor,
                ),
                suffixIcon: GestureDetector(
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
          Obx(() => AnimatedSwitcher(
                layoutBuilder: (currentChild, previousChildren) =>
                    currentChild!,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                duration: const Duration(milliseconds: 200),
                child: controller.signUpProgress.value == false
                    ? ClipRRect(
                        key: const ValueKey(6),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Constants.defaultRadius)),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.find<AuthenticationController>()
                                  .infoMsg
                                  .clear();

                              final eText = controller.emailController.text;
                              final pText = controller.passwordController.text;
                              final cPText = controller.cPassController.text;
                              if (eText.isEmpty) {
                                GetXUtilities.snackbar(
                                    title: 'Error!',
                                    message: 'Email not be empty!',
                                    gradient: errorGradient);
                              } else if (pText.isEmpty) {
                                GetXUtilities.snackbar(
                                    title: 'Error!',
                                    message: 'Password not be empty!',
                                    gradient: errorGradient);
                              } else if (cPText.isEmpty) {
                                GetXUtilities.snackbar(
                                    title: 'Error!',
                                    message: 'Confirm the password!',
                                    gradient: errorGradient);
                              } else if (pText != cPText) {
                                GetXUtilities.snackbar(
                                    title: 'Error!',
                                    message: 'Passwords not match',
                                    gradient: errorGradient);
                              } else {
                                final email = eText +
                                    controller.respectedEmailSuffixes[
                                        Get.find<AuthenticationController>()
                                            .segmentedControlGroupValue
                                            .value];
                                controller.signUpUser(
                                    email: email, password: pText);
                              }
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.all(Constants.defaultPadding * 2),
                              child: Text('Sign Up',
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            )),
                      )
                    : const SpinKitFadingCircle(
                        key: ValueKey(5),
                        size: 50,
                        color: primaryColor,
                      ),
              )),
          kHeight,
          kHeight,
          kHeight,
          kHeight,
          Text(
            "Or, SIGN UP WITH...",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.black),
          ),
          kHeight,
          kHeight,
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    // foregroundColor:
                    //     MaterialStateProperty.all(Colors.blue),
                    side: MaterialStateProperty.all(const BorderSide(
                        color: primaryColor,
                        width: 2.0,
                        style: BorderStyle.solid)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius))),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding * 1.5),
                      child: Image.asset(
                        'assets/sign_in/google.png',
                        width: Constants.iconSize,
                      )),
                ),
              ]),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  Get.find<AuthenticationController>().isSignIn.value =
                      !Get.find<AuthenticationController>().isSignIn.value;
                },
                child: Container(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Text(
                    // "Register yourself",
                    "SIGN IN",
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
