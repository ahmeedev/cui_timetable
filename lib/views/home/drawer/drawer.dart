import 'package:cui_timetable/style.dart';
import 'package:cui_timetable/views/developers/developer.dart';
import 'package:cui_timetable/views/firebase/firebase.dart';
import 'package:cui_timetable/views/sync/sync.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Header of the Drawer.
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: primaryColor),
      accountName: const Text(""),
      accountEmail: Text(
        "No details available",
        style: Theme.of(context).textTheme.titleMedium,
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
            title: 'Director Vision',
            onTap: () {}),
        buildButton(context,
            icon: const AssetImage('assets/drawer/about_us.png'),
            title: 'About Us',
            onTap: () {}),
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
          Get.to(() => const Sync());
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
  InkWell buildButton(context,
      {required onTap, required title, required icon}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
          // dense: true,
          // contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          // visualDensity: VisualDensity(horizontal: 0, vertical: 0),
          leading: ImageIcon(
            icon,
            color: primaryColor,
          ),
          title: Text(title, style: Theme.of(context).textTheme.titleSmall)),
    );
  }
}
