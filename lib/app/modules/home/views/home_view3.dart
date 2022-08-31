import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../../routes/app_pages.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_widgets.dart';

class HomeView3 extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widgetsPlaceholderHeight = height * 0.52 + 15;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
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
              Positioned(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: width,
                      height: height * 0.4,
                      decoration: const BoxDecoration(
                          // color: primaryColor,
                          gradient: LinearGradient(colors: primaryGradient)),
                      child: Obx(() => Text(
                            controller.pageLabels[controller.pageIndex.value],
                            style: textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .fontSize! +
                                    4.0),
                          )),
                    ),
                    _buildParticles(width, height),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Constants.defaultPadding),
                    child: Container(
                      width: width,
                      height: widgetsPlaceholderHeight,
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
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: SingleChildScrollView(
                          child: Obx(() => controller
                              .pageWidget[controller.pageIndex.value])),
                    ),
                  ),
                ],
              ),
              Padding(
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
                          if (Get.find<HomeController>().isNews.value ==
                              false) {
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
                                color:
                                    Get.find<HomeController>().isNews.value ==
                                            true
                                        ? selectionColor
                                        : Colors.transparent,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Constants.defaultPadding),
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
                          if (Get.find<HomeController>().isHome.value ==
                              false) {
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
                                color:
                                    Get.find<HomeController>().isHome.value ==
                                            true
                                        ? selectionColor
                                        : Colors.transparent,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Constants.defaultPadding),
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
                                color: Get.find<HomeController>()
                                            .isSetting
                                            .value ==
                                        true
                                    ? selectionColor
                                    : Colors.transparent,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Constants.defaultPadding),
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
        Text(
          "Events",
          style: textTheme.titleMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          children: [
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Meetups", iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Socities", iconLocation: "assets/home/room.png"),
            _buildTile(context, blank: true),
            _buildTile(context, blank: true),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),
        SizedBox(height: Constants.defaultPadding),
        Text(
          "Academic",
          style: textTheme.titleMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Timetable",
                ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/timetable.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Datesheet",
                ontap: () => Get.toNamed(Routes.DATESHEET),
                iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Freerooms",
                ontap: () => Get.toNamed(Routes.FREEROOMS),
                iconLocation: "assets/home/room.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Comparision", iconLocation: "assets/home/menu.png"),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Transport",
                // ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/transport.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Fee Structure",
                // ontap: () => Get.toNamed(Routes.DATESHEET),
                iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context, blank: true),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context, blank: true),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),
        SizedBox(height: Constants.defaultPadding),
        Text(
          "General",
          style: textTheme.titleMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Feedback",
                // ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/feedback.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "About Us",
                ontap: () => Get.toNamed(Routes.ABOUT_US),
                iconLocation: "assets/home/about_us.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Donation",
                // ontap: () => Get.toNamed(Routes.FREEROOMS),
                iconLocation: "assets/home/donation.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(
              context,
              title: "Developers",
              iconLocation: "assets/home/developer.png",
              ontap: () => Get.toNamed(Routes.DEVELOPER),
            ),
          ],
        ),
        SizedBox(height: Constants.defaultPadding + 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Load More...",
              style: textTheme.labelLarge!.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        )
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     SizedBox(width: Constants.defaultPadding),
        //     _buildTile(context,
        //         title: "Feedback",
        //         // ontap: () => Get.toNamed(Routes.TIMETABLE),
        //         iconLocation: "assets/home/timetable.png"),
        //     SizedBox(width: Constants.defaultPadding),
        //     _buildTile(context,
        //         title: "About Us",
        //         // ontap: () => Get.toNamed(Routes.DATESHEET),
        //         iconLocation: "assets/home/datesheet.png"),
        //     SizedBox(width: Constants.defaultPadding),
        //     _buildTile(context,
        //         title: "Donation",
        //         // ontap: () => Get.toNamed(Routes.FREEROOMS),
        //         iconLocation: "assets/home/room.png"),
        //     SizedBox(width: Constants.defaultPadding),
        //     _buildTile(context,
        //         title: "Contribute", iconLocation: "assets/home/menu.png"),
        //   ],
        // ),
      ],
    );
  }
}

_buildTile(context,
    {String title = "", String iconLocation = "", ontap, blank = false}) {
  final textTheme = Theme.of(context).textTheme;
  return Flexible(
    child: FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
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
    ),
  );
}
