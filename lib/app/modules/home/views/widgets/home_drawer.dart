// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cui_timetable/app/constants/notification_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

import '../../../../data/services/local_notifications.dart';
import '../../controllers/home_controller.dart';

/// Header of the Drawer.
class Header extends GetView<HomeController> {
  const Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return UserAccountsDrawerHeader(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       end: Alignment.bottomRight,
    //       colors: [
    //         // secondaryColor,
    //         primaryColor,
    //         forGradient,
    //       ],
    //     ),
    //   ),
    //   currentAccountPictureSize: Size.square(80),
    //   accountName: const Text(""),
    //   accountEmail: Text(
    //     "No details available",
    //     style: Theme.of(context)
    //         .textTheme
    //         .titleMedium!
    //         .copyWith(color: Colors.white),
    //   ),
    //   currentAccountPicture: CircleAvatar(
    //     backgroundColor: Theme.of(context).secondaryHeaderColor,
    //     child: const Text(
    //       "A",
    //       style: TextStyle(fontSize: 40.0),
    //     ),
    //   ),
    // );

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        end: Alignment.bottomRight,
        colors: [
          // secondaryColor,
          primaryColor,
          forGradient,
        ],
      )),
      height: 
           MediaQuery.of(context).size.height * 0.28 + Constants.defaultPadding,

              
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: Colors.white)),
                  child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding / 3).copyWith(
                        bottom: 0,
                      ),
                      child: Obx(() => Container(
                            width: Constants.imageWidth + 20,
                            height: Constants.imageHeight + 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: controller.isUserSignIn.value == false
                                    ? DecorationImage(
                                        image: AssetImage(
                                            'assets/drawer/comsats.png'))
                                    : FirebaseAuth.instance.currentUser!
                                                .photoURL ==
                                            null
                                        ? DecorationImage(
                                            image: AssetImage(
                                                'assets/drawer/comsats.png'))
                                        : DecorationImage(
                                            // image:AssetImage(''),
                                            image: CachedNetworkImageProvider(
                                              FirebaseAuth.instance
                                                  .currentUser!.photoURL!,
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                          )))),
              SizedBox(height: Get.height*0.02,),
              Obx(() => Padding(
                padding:  EdgeInsets.only(top: 4),
                child: Text(
                      // "No details Available",
                      controller.isUserSignIn.value == true
                          ? 'Welcome,  ${FirebaseAuth.instance.currentUser!.email!.substring(
                              0,
                              FirebaseAuth.instance.currentUser!.email!
                                  .indexOf('@'),
                            )}'
                          : "Welcome, to CUI Sahiwal",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
              )),
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   height: MediaQuery.of(context).size.height / 5.1,
    //   decoration: const BoxDecoration(
    //       // gradient: const LinearGradient(
    //       //   colors: [
    //       //     primaryColor,
    //       //     secondaryColor,
    //       //   ],
    //       // ),
    //       color: primaryColor),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //           padding: const EdgeInsets.fromLTRB(Constants.defaultPadding * 1.5,
    //               Constants.defaultPadding * 2, Constants.defaultPadding, Constants.defaultPadding),
    //           child: Container(
    //             padding: const EdgeInsets.all(30),
    //             decoration: const BoxDecoration(
    //                 color: Colors.white60, shape: BoxShape.circle),
    //             child: Text(
    //               'A',
    //               style: Theme.of(context).textTheme.headlineMedium,
    //             ),
    //           )),
    //       Padding(
    //         padding: const EdgeInsets.only(left: Constants.defaultPadding * 1.5),
    //         child: Text(
    //           'No Details Available',
    //           style: Theme.of(context)
    //               .textTheme
    //               .titleMedium!
    //               .copyWith(color: Colors.white),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

/// Button List for Drawer.
class ButtonList extends GetView<HomeController> {
  const ButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          buildButton(context,
              icon: const AssetImage('assets/drawer/vision.png'),
              title: 'Director Vision', onTap: () {
            Get.toNamed(Routes.DIRECTOR_VISION);
          }),
          // buildButton(context,
          //     icon: const AssetImage('assets/drawer/about_us.png'),
          //     title: 'About Us', onTap: () {
          //   Get.toNamed(Routes.ABOUT_US);
          // }),

          // buildButton(context,
          //     icon: const AssetImage('assets/drawer/bookings.png'),
          //     title: 'Bookings',
          //     onTap: () {}),
          if (FirebaseAuth.instance.currentUser?.email == "inahmee77@gmail.com" || FirebaseAuth.instance.currentUser?.email == "mnawazshah49@gmail.com" )
            buildButton(context,
                icon: const AssetImage('assets/drawer/developer.png'),
                title: 'Admin Panel',
                onTap: () => Get.toNamed(Routes.ADMIN_PANEL)),
          buildButton(context,
              icon: const AssetImage('assets/drawer/sync.png'),
              title: 'Synchronize', onTap: () {
            Get.toNamed(Routes.SYNC);
          }),

          // buildButton(context,
          //     icon: const AssetImage('assets/drawer/feedback.png'),
          //     title: 'Feedback / Report an Issue',
          //     onTap: () {}),
          // buildButton(context,
          //     icon: const AssetImage('assets/drawer/settings.png'),
          //     title: 'Settings', onTap: () {
          //   Get.toNamed(Routes.SETTINGS);
          // }),
          // controller.authCache.get(DBAuthCache.isSignIn, defaultValue: false)

          // Stack(
          //   children: [
          //     buildButton(context,
          //         icon: const AssetImage('assets/drawer/remainder.png'),
          //         title: 'Remainder', onTap: () {
          //       Get.toNamed(Routes.REMAINDER);
          //     }),
          //     Align(
          //       alignment: Alignment.topRight,
          //       child: Container(
          //         // width: 30,
          //         decoration: BoxDecoration(
          //             color: primaryColor,
          //             borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(Constants.defaultRadius),
          //                 bottomRight:
          //                     Radius.circular(Constants.defaultRadius))),
          //         // height: 30,
          //         child: Text(
          //           "Beta",
          //           style: theme.textTheme.labelMedium!.copyWith(
          //               color: Colors.white, fontWeight: FontWeight.w900),
          //         ).paddingAll(Constants.defaultPadding * 0.8),
          //       ).paddingOnly(right: 4),
          //     ),
          //   ],
          // ),

          Obx(() => controller.isUserSignIn.value == true
              ? buildButton(context,
                  icon: const AssetImage('assets/drawer/sign_out.png'),
                  title: 'Sign out', onTap: () async {
                  controller.isUserSignIn.value = false;
                  // controller.authCache.put(DBAuthCache.isSignIn, false);
                  await FirebaseAuth.instance.signOut();
                  Get.back();
                  GetXUtilities.snackbar(
                      title: 'Sign Out',
                      message: 'Sign out successfully!',
                      gradient: successGradient);
                  // Get.offAndToNamed(Routes.AUTHENTICATION);
                })
              : buildButton(context,
                  icon: const AssetImage('assets/drawer/sign_in.png'),
                  title: 'Sign In', onTap: () {
                  //
                  Get.offAndToNamed(Routes.AUTHENTICATION);
                })),

          // buildButton(context,
          //     icon: const AssetImage('assets/drawer/settings.png'),
          //     title: 'Settings', onTap: () {
          //   final result = FirebaseAuth.instance.currentUser;
          //   print(result);
          // }),

          // buildButton(context,
          //     icon: const AssetImage('assets/drawer/firebase.png'),
          //     title: 'Firebase', onTap: () {
          //   Get.to(FirebaseUI());
          // }),

          if (kDebugMode)
            buildButton(context,
                icon: const AssetImage('assets/drawer/vision.png'),
                title: 'Testing', onTap: () {
              LocalNotifications.showBigTextNotification(
                channelID: channelRemainderId,
                channelName: channelRemainder,
                title: 'This is a big title',
                body:
                    "This is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThidyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThidyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a bodyThis is a body",
              );
            }),
        ],
      ),
    );
  }

  /// Drawer button Template.
  Material buildButton(context,
      {required onTap, required title, required icon}) {
    return Material(
      color: scaffoldColor,
      child: InkWell(
        onTap: onTap,
        splashColor: selectionColor,
        highlightColor: Colors.transparent,
        child: ListTile(
            // dense: true,
            // contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            // visualDensity: VisualDensity(horizontal: 1, vertical: 0),
            // onTap: onTap,
            leading: icon is AssetImage
                ? ImageIcon(
                    icon,
                    color: primaryColor,
                    size: Constants.iconSize,
                  )
                : Icon(
                    icon,
                    color: primaryColor,
                    size: Constants.iconSize,
                  ),
            title: Text(title, style: Theme.of(context).textTheme.titleSmall)),
      ),
    );
  }
}
