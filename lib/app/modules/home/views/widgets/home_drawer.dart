import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Header of the Drawer.
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: primaryColor),
      currentAccountPictureSize: const Size.square(80),
      accountName: const Text(""),
      accountEmail: Text(
        "No details available",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        child: const Text(
          "A",
          style: TextStyle(fontSize: 40.0),
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
    //           padding: const EdgeInsets.fromLTRB(defaultPadding * 1.5,
    //               defaultPadding * 2, defaultPadding, defaultPadding),
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
    //         padding: const EdgeInsets.only(left: defaultPadding * 1.5),
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
class ButtonList extends StatelessWidget {
  const ButtonList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildButton(context,
            icon: const AssetImage('assets/drawer/vision.png'),
            title: 'Director Vision', onTap: () {
          Get.toNamed(Routes.DIRECTOR_VISION);
        }),
        buildButton(context,
            icon: const AssetImage('assets/drawer/about_us.png'),
            title: 'About Us', onTap: () {
          Get.toNamed(Routes.ABOUT_US);
        }),
        buildButton(context,
            icon: const AssetImage('assets/drawer/remainder.png'),
            title: 'Remainder',
            onTap: () {}),
        buildButton(context,
            icon: const AssetImage('assets/drawer/bookings.png'),
            title: 'Bookings',
            onTap: () {}),
        buildButton(context,
            icon: const AssetImage('assets/drawer/sync.png'),
            title: 'Synchronized', onTap: () {
          // Get.to(() => const Sync());
        }),
        buildButton(context,
            icon: const AssetImage('assets/drawer/feedback.png'),
            title: 'Feedback / Report an Issue',
            onTap: () {}),
        buildButton(context,
            icon: const AssetImage('assets/drawer/sign_in.png'),
            title: 'Sign In',
            onTap: () {}),
        // buildButton(context,
        //     icon: const AssetImage('assets/drawer/settings.png'),
        //     title: 'Settings', onTap: () {
        //   Get.to(() => const Settings(), transition: Transition.cupertino);
        // }),
        // buildButton(context,
        //     icon: const AssetImage('assets/drawer/developer.png'),
        //     title: 'For Developer', onTap: () {
        //   Get.to(() => Developer());
        // }),
        // buildButton(context,
        //     icon: const AssetImage('assets/drawer/firebase.png'),
        //     title: 'Firebase', onTap: () {
        //   Get.to(FirebaseUI());
        // }),
      ],
    );
  }

  /// Drawer button Template.
  Material buildButton(context,
      {required onTap, required title, required icon}) {
    return Material(
      color: scaffoldColor,
      child: InkWell(
        onTap: onTap,
        splashColor: primaryColor,
        child: ListTile(
            // dense: true,
            // contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            // visualDensity: VisualDensity(horizontal: 0, vertical: 0),
            // onTap: onTap,
            leading: ImageIcon(
              icon,
              color: primaryColor,
            ),
            title: Text(title, style: Theme.of(context).textTheme.titleSmall)),
      ),
    );
  }
}