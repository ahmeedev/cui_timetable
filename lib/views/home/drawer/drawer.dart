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
      accountName: const Text(""),
      accountEmail: const Text("No details available"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
        child: const Text(
          "A",
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}

/// Button List for Drawer.
class ButtonList extends StatelessWidget {
  const ButtonList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildButton(
            icon: Icons.visibility_outlined,
            title: 'Director Vision',
            onTap: () {
              print('working');
              print('Director Vision');
            }),
        buildButton(
            icon: Icons.info,
            title: 'About Us',
            onTap: () {
              print('About Us');
            }),
        buildButton(
            icon: Icons.info,
            title: 'Remainder',
            onTap: () {
              print('Remainder');
            }),
        buildButton(
            icon: Icons.info,
            title: 'Bookings',
            onTap: () {
              print('Bookings');
            }),
        buildButton(
            icon: Icons.sync,
            title: 'Synchronized',
            onTap: () {
              Get.to(() => Sync());
            }),
        buildButton(
            icon: Icons.info,
            title: 'Feedback / Report an Issue',
            onTap: () {
              print('Feedback / Report an Issue');
            }),
        buildButton(
            icon: Icons.info,
            title: 'Sign In',
            onTap: () {
              print('Sign In');
            }),
        buildButton(
            icon: Icons.info,
            title: 'For Developer',
            onTap: () {
              Get.to(() => Developer());
            }),
        buildButton(
            icon: Icons.info,
            title: 'Firebase',
            onTap: () {
              Get.to(FirebaseUI());
            }),
      ],
    );
  }

  /// Drawer button Template.
  InkWell buildButton({required onTap, required title, required icon}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
