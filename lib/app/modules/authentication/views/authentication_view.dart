import 'package:cui_timetable/app/modules/authentication/signIn/views/sign_in_view.dart';
import 'package:cui_timetable/app/modules/authentication/signUp/views/sign_up_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../../widgets/global_widgets.dart';

import 'package:particles_flutter/particles_flutter.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);

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
          Stack(
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
                      Obx(
                        () => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                            child: Text(
                              controller.isSignIn.value
                                  ? "SIGN IN"
                                  : "Register Yourself",
                              key: controller.isSignIn.value
                                  ? const ValueKey(0)
                                  : const ValueKey(1),
                              style: textTheme.titleLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .fontSize! +
                                      4.0),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              _buildParticles(width, height),
              SafeArea(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Constants.defaultPadding),
                        child: Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: Constants.iconSize + 5),
                      ),
                    ),
                    const Spacer(),
                    Obx(() => CupertinoSlidingSegmentedControl(
                        backgroundColor: selectionColor,
                        thumbColor: primaryColor,

                        // padding: EdgeInsets.all(Constants.defaultPadding / 2),
                        groupValue: controller.segmentedControlGroupValue.value,
                        children: controller.myTabs!,
                        onValueChanged: (i) {
                          print("here");
                          controller.segmentedControlGroupValue.value =
                              int.parse(i.toString());

                          for (var i = 0; i < controller.styles.length; i++) {
                            controller.styles[i] = controller.normalStyle;
                          }
                          controller.styles[controller
                              .segmentedControlGroupValue
                              .value] = controller.selectedStyle;
                        })),
                    kWidth,
                    // kWidth,
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
              child: SizedBox(
                  height: height * 0.28,
                  child: Padding(
                    padding: EdgeInsets.all(Constants.defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => controller.infoMsg.isEmpty
                            ? const SizedBox()
                            : FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  // alignment: WrapAlignment.center,
                                  // key: ValueKey(controller.infoMsg.length),
                                  children: [
                                    Icon(Icons.info_outline_rounded,
                                        color: Colors.white,
                                        size: Constants.iconSize),
                                    kWidth,
                                    Text(
                                      controller.infoMsg[
                                              controller.infoMsg.length - 1]
                                          .toString(),
                                      style: textTheme.labelMedium!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                      ],
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
            child: Column(
              children: [
                Container(
                  height: height * 0.32,
                  // color: Colors.red,
                ),
                Container(
                  width: width,
                  height: height * 0.68 - Constants.defaultPadding,

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
                  child: Obx(() => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) => ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                      child: controller.isSignIn.value
                          ? const SignInView()
                          : const SignUpView())),

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
