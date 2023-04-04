import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../../routes/app_pages.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_widgets.dart';

class HomeView3 extends GetView<HomeController> {
  const HomeView3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final widgetsPlaceholderHeight = height * 0.52 + 0; //! add 15
    // final widgetsPlaceholderHeight = height * 0.5; //! add 15

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        // appBar: AppBar(),
        key: controller.scaffoldKey,
        backgroundColor: selectionColor,
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          width: width / 1.5,
          child: Container(
            color: scaffoldColor,
            child: Column(
              children: const [Header(), ButtonList()],
            ),
          ),
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(() => Container(
                  width: width,
                  height: height * 0.4,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      // color: primaryColor,
                      gradient: LinearGradient(colors: primaryGradient)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Constants.defaultPadding,
                        horizontal: Constants.defaultPadding * 2),
                    child:
                        Text(controller.pageLabels[controller.pageIndex.value],
                            style: textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: textTheme.displayMedium!.fontSize! - 12,
                            )),
                  ),
                )),
            _buildMainPlaceholder(context),
            _bulidTopDrawerRow(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding).copyWith(top: 0),
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Constants.defaultRadius * 2),
              ),
            ),
            child: Container(
              width: width,
              height: height * 0.1,
              // height: 0,

              // padding: EdgeInsets.all(Constants.defaultPadding),
              decoration: BoxDecoration(
                // color: primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.all(
                  Radius.circular(Constants.defaultRadius * 2),
                ),
                gradient: const LinearGradient(colors: primaryGradient),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.2),
                //     blurRadius: 10,
                //     spreadRadius: 2,
                //   ),
                // ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (Get.find<HomeController>().isNews.value == false) {
                          Get.find<HomeController>().setToFalse();
                          Get.find<HomeController>().isNews.value = true;
                          Get.find<HomeController>().pageIndex.value = 0;
                        }
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Constants.defaultRadius),
                              ),
                              color: Get.find<HomeController>().isNews.value ==
                                      true
                                  ? selectionColor
                                  : Colors.transparent,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Constants.defaultPadding),
                              child: Icon(
                                Icons.newspaper,
                                size: Constants.iconSize,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        if (Get.find<HomeController>().isHome.value == false) {
                          Get.find<HomeController>().setToFalse();
                          Get.find<HomeController>().isHome.value = true;
                          Get.find<HomeController>().pageIndex.value = 1;
                        }
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Constants.defaultRadius),
                              ),
                              color: Get.find<HomeController>().isHome.value ==
                                      true
                                  ? selectionColor
                                  : Colors.transparent,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Constants.defaultPadding),
                              child: Icon(
                                Icons.home,
                                size: Constants.iconSize,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        if (Get.find<HomeController>().isSetting.value ==
                            false) {
                          Get.find<HomeController>().setToFalse();
                          Get.find<HomeController>().isSetting.value = true;
                          Get.find<HomeController>().pageIndex.value = 2;
                        }
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Constants.defaultRadius),
                              ),
                              color:
                                  Get.find<HomeController>().isSetting.value ==
                                          true
                                      ? selectionColor
                                      : Colors.transparent,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Constants.defaultPadding),
                              child: Icon(
                                Icons.settings,
                                size: Constants.iconSize,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                    // Icon(Icons.home, size: Constants.iconSize),
                    // Icon(Icons.home, size: Constants.iconSize),
                  ]),
            ),
          ),
        )
        // .roundAll(Constants.defaultRadius * 2)
        // .paddingAll(Constants.defaultPadding)
        );
  }

  SingleChildScrollView _buildMainPlaceholder(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            // color: Colors.red,
            height: height * 0.32,
            child: buildParticles(width, height * 0.4),
          ),
          Padding(
            padding:
                EdgeInsets.all(Constants.defaultPadding).copyWith(bottom: 0),
            child: Container(
              width: width,
              height: height * 0.58 - (Constants.defaultPadding * 3),
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
              // padding: EdgeInsets.all(Constants.defaultPadding),
              child: SingleChildScrollView(
                  // physics: const BouncingScrollPhysics(),
                  child: Obx(
                      () => controller.pageWidget[controller.pageIndex.value])),
            ),
          ),
        ],
      ),
    );
  }

  SafeArea _bulidTopDrawerRow() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: Row(
          children: [
            InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //  hoverColor: Colors.tra

                onTap: () {
                  controller.scaffoldKey.currentState!.openDrawer();
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    decoration: BoxDecoration(
                      // color: selectionColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.defaultRadius),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: ImageIcon(
                        const AssetImage('assets/drawer/menu2.png'),
                        color: Colors.white,
                        size: Constants.iconSize - 4,
                      ),
                    ),
                  ),
                )),
            const Spacer(),
            const TypeWriterText()
          ],
        ),
      ),
    );
  }
}

CircularParticle buildParticles(double width, double height) {
  return CircularParticle(
    key: UniqueKey(),
    awayRadius: 80,
    numberOfParticles: 10,
    speedOfParticles: 1,
    width: width,
    height: height,
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

class HomeViewWidget extends StatelessWidget {
  const HomeViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        const UpdateTile(),
        _buildTag(context: context, text: 'Academic'),
        kHeight,
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            kWidth,
            _buildTile(context,
                title: "Timetable",
                ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/timetable.png"),
            kWidth,
            _buildTile(context,
                title: "Freerooms",
                ontap: () => Get.toNamed(Routes.FREEROOMS),
                iconLocation: "assets/home/room.png"),
            kWidth,
            _buildTile(context,
                title: "Datesheet",
                ontap: () => Get.toNamed(Routes.DATESHEET),
                iconLocation: "assets/home/datesheet.png"),
            kWidth,
            _buildTile(context,
                title: "Comparision",
                iconLocation: "assets/home/menu.png",
                ontap: () => Get.toNamed(Routes.COMPARISON)),
            kWidth,
          ],
        ),
        kHeight,
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kWidth,
            _buildTile(context, title: "Booking", ontap: () {
              String? email = FirebaseAuth.instance.currentUser?.email;

              // if (email!.endsWith("@cuisahiwal.edu.pk")) {
              if (email == null) {
                GetXUtilities.snackbar(
                    title: "Error!",
                    message:
                        "You must be sign in as a teacher to start booking",
                    gradient: errorGradient);
              } else {
                // if (email.endsWith("@gmail.com")) {
                if (email.endsWith("@gmail.com")) {
                  // Get.toNamed(Routes.BOOKING);
                  Get.find<HomeController>().approveAndGoToBooking();
                } else {
                  GetXUtilities.snackbar(
                      title: "Error!",
                      message:
                          "You must be sign in as a teacher to start booking",
                      gradient: errorGradient);
                }
              }
            }, iconLocation: "assets/home/booking.png"),
            kWidth,
            _buildTile(context,
                title: "Socities",
                upComing: true,
                iconLocation: "assets/home/room.png", ontap: () {
              GetXUtilities.snackbar(
                  title: "In Development!",
                  message: "This Module is Under Development",
                  gradient: primaryGradient);
            }),
            kWidth,
            _buildTile(context, title: "Transport", ontap: () {
              GetXUtilities.snackbar(
                  title: "In Development!",
                  message: "This Module is Under Development",
                  gradient: primaryGradient);
            }, iconLocation: "assets/home/transport.png"),
            kWidth,
            _buildTile(context,
                title: "Meetups",
                iconLocation: "assets/home/datesheet.png", ontap: () {
              GetXUtilities.snackbar(
                  title: "In Development!",
                  message: "This Module is Under Development",
                  gradient: primaryGradient);
            }),
            kWidth,
          ],
        ),
        kHeight,
        kHeight,
        kHeight,
        _buildTag(context: context, text: 'Miscellaneous'),
        kHeight,
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kWidth,
            _buildTile(context,
                title: "Locations",
                ontap: () => Get.toNamed(Routes.LOCATION),
                iconLocation: "assets/timetable/location.png"),
            kWidth,
            _buildTile(context,
                title: "About Us",
                ontap: () => Get.toNamed(Routes.ABOUT_US),
                iconLocation: "assets/home/about_us.png"),
            kWidth,
            _buildTile(context, title: "Feedback", ontap: () {
              String? email = FirebaseAuth.instance.currentUser?.email;

              // if (email!.endsWith("@cuisahiwal.edu.pk")) {
              if (email == null) {
                GetXUtilities.snackbar(
                    title: "Error!",
                    message: "You must be signed in to report an issue",
                    gradient: errorGradient);
              } else {
                if (email.endsWith("@gmail.com")) {
                  Get.toNamed(Routes.REPORTS);
                } else {
                  GetXUtilities.snackbar(
                      title: "Error!",
                      message: "You must be signed in to report an issue",
                      gradient: primaryGradient);
                }
              }
            }, iconLocation: "assets/home/feedback.png"),
            kWidth,
            _buildTile(
              context,
              title: "Contribution",
              iconLocation: "assets/home/developer.png",
              ontap: () => Get.toNamed(Routes.CONTRIBUTIONS),
            ),
            kWidth,
          ],
        ),
      ],
    );
  }
}

_buildTag({required context, required text}) {
  final theme = Theme.of(context);

  return Card(
      color: primaryColor.withOpacity(0.8),
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Constants.defaultRadius / 2),
              bottomRight: Radius.circular(Constants.defaultRadius / 2))),
      margin: EdgeInsets.zero,
      child: Text(
        text,
        style: theme.textTheme.titleSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
      ).paddingAll(Constants.defaultPadding)
      // .paddingSymmetric(horizontal: Constants.defaultPadding),
      );
  // .paddingSymmetric(horizontal: Constants.defaultPadding);
}

_buildTile(context,
    {String title = "",
    String iconLocation = "",
    ontap,
    blank = false,
    bool upComing = false}) {
  final textTheme = Theme.of(context).textTheme;
  return Flexible(
    child: FractionallySizedBox(
      widthFactor: 0.9,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicWidth(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Constants.defaultRadius),
                        topRight: Radius.circular(Constants.defaultRadius)),
                    gradient: LinearGradient(
                      end: Alignment.bottomRight,
                      colors: blank == true
                          ? [
                              Colors.transparent,
                              Colors.transparent,
                            ]
                          : [
                              // secondaryColor,
                              primaryColor,
                              forGradient,
                            ],
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding - 2,
                        vertical: Constants.defaultPadding / 2,
                      ),
                      child: Text(
                        title,
                        style: textTheme.labelLarge!.copyWith(
                            fontSize: textTheme.labelLarge!.fontSize! - 2,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              blank == true
                  ? const SizedBox()
                  : Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Constants.defaultRadius),
                        bottomRight: Radius.circular(Constants.defaultRadius),
                      )),
                      margin: EdgeInsets.zero,
                      // color: Color(0xffB0CAEC),
                      color: widgetColor,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Constants.defaultRadius),
                          bottomRight: Radius.circular(Constants.defaultRadius),
                        ),
                        splashColor: selectionColor,
                        highlightColor: Colors.transparent,
                        onTap: ontap,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Constants.defaultPadding * 2.2,
                                vertical: Constants.defaultPadding,
                              ),
                              // .copyWith(
                              //     top: Constants.defaultPadding / 2),
                              child: ImageIcon(
                                AssetImage(iconLocation),
                                // size: Constants.iconSize,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          // upComing
          //     ? const Positioned(
          //         left: 0,
          //         right: 0,
          //         bottom: 0,
          //         child: Banner(
          //           layoutDirection: TextDirection.ltr,
          //           message: 'Upcoming',
          //           location: BannerLocation.bottomEnd,
          //           // color: Colors.amber,
          //           // child: const Text("Upcoming").paddingAll(2),
          //         ))
          //     : const SizedBox()
        ],
      ),
    ),
  );
}
