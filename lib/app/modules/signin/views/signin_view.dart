import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../../widgets/global_widgets.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // key: controller.scaffoldKey,
      backgroundColor: selectionColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SafeArea(
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  // alignment: controller.pageIndex.value == 0
                  //     ? const Alignment(-0.9, -0.6)
                  //     : Alignment.center,
                  width: width,
                  height: height * 0.4,
                  decoration: const BoxDecoration(
                      // color: primaryColor,
                      gradient: LinearGradient(colors: primaryGradient)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Constants.defaultPadding,
                        horizontal: Constants.defaultPadding * 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight,
                        kHeight,
                        Text(
                          'SIGN IN',
                          style: textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .fontSize! +
                                  4.0),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildParticles(width, height),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Constants.defaultPadding),
                    child: Icon(Icons.arrow_back,
                        color: Colors.white, size: Constants.iconSize + 10),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
            child: Column(
              children: [
                Container(
                  height: height * 0.4,
                  // color: Colors.red,
                ),
                Container(
                  width: width,
                  height: height * 0.6 - Constants.defaultPadding,

                  decoration: BoxDecoration(
                    color: onScaffoldColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Constants.defaultRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(Constants.defaultPadding * 2),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              fillColor: textFieldColor,
                              hintText: "Enter your email",
                              // filled: true,
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Constants.defaultRadius),
                                  borderSide: const BorderSide(
                                    color: primaryColor,
                                  )),
                            )),
                        kHeight,
                        kHeight,
                        TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              fillColor: textFieldColor,
                              hintText: "Enter your passsword",
                              // filled: true,
                              prefixIcon: const Icon(Icons.password),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Constants.defaultRadius),
                                  borderSide: const BorderSide(
                                    color: primaryColor,
                                  )),
                            )),
                        kHeight,
                        kHeight,
                        kHeight,
                        kHeight,
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Constants.defaultRadius)),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Constants.defaultPadding * 2),
                                child: Text('Sign in',
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                              )),
                        ),
                        kHeight,
                        kHeight,
                        kHeight,
                        kHeight,
                        Text(
                          "Or, Sign in with...",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.black),
                        ),
                        kHeight,
                        kHeight,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  // foregroundColor:
                                  //     MaterialStateProperty.all(Colors.blue),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: primaryColor,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Constants.defaultRadius))),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Constants.defaultPadding), // 16.0
                                  child: Icon(
                                    Icons.facebook,
                                    color: Colors.blue,
                                    size: Constants.iconSize,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  // foregroundColor:
                                  //     MaterialStateProperty.all(Colors.blue),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: primaryColor,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Constants.defaultRadius))),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Constants.defaultPadding), // 16.0
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.red,
                                    size: Constants.iconSize,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  // foregroundColor:
                                  //     MaterialStateProperty.all(Colors.blue),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: primaryColor,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Constants.defaultRadius))),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Constants.defaultPadding), // 16
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
                                  .labelMedium!
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              // "Register yourself",
                              "Sign up",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                      ]),

                  // child: SingleChildScrollView(
                  //     // physics: const BouncingScrollPhysics(),
                  //     child: Obx(() => controller
                  //         .pageWidget[controller.pageIndex.value])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CircularParticle _buildParticles(double width, double height) {
    return CircularParticle(
      key: UniqueKey(),
      awayRadius: 80,
      numberOfParticles: 10,
      speedOfParticles: 1,
      width: width,
      height: height * 0.4,
      onTapAnimation: true,
      particleColor: Colors.white.withAlpha(150),
      awayAnimationDuration: const Duration(milliseconds: 500),
      maxParticleSize: 5,
      isRandSize: true,
      isRandomColor: true,
      randColorList: const [
        Colors.purple,
        Colors.amber,
        Colors.red,
        // Colors.black,
        Colors.orange,
      ],
      awayAnimationCurve: Curves.easeInOutBack,
      enableHover: true,
      hoverColor: Colors.white,
      hoverRadius: 90,
      connectDots: false, //not recommended
    );
  }
}
