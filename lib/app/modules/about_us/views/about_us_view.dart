import 'package:cui_timetable/app/modules/about_us/views/widgets/about_us_tile.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            AboutUsTile(
              pic: 'ahmad.jpg',
              name: 'Ahmad Shaf',
              position: 'Team Manager',
              description: 'CUI Software House Coordinator',
            ),
            AboutUsTile(
              pic: 'ahmad.jpg',
              name: 'Ahmad Tariq',
              position: 'Developer',
              description: 'CUI Computer Science Student',
            ),
            AboutUsTile(
              pic: 'shah.jpeg',
              name: 'Nawaz Shah',
              position: 'Developer',
              description: 'CUI Computer Science Student',
            ),
          ],
        ),
      ),
    );
  }
}
