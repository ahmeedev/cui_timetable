import 'package:cui_timetable/app/modules/ui/about_us/widgets/about_us_tile.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            AboutUsTile(
              pic: 'ahmad_shaf.jpg',
              name: 'Ahmad Shaf',
              subName: '',
              position: 'Team Manager',
              description: 'CUI Software House Coordinator',
            ),
            AboutUsTile(
              pic: 'ahmad.jpg',
              name: 'Ahmad Tariq',
              subName: '',
              position: 'C.E.O',
              description: 'CUI Computer Science Student',
            ),
            //   AboutUsTile(
            //   pic: 'naeem.jpg',
            //   name: 'Naeem',
            //   subName: 'Yousaf Khokhar',
            //   position: 'Developer',
            //   description: 'CUI Computer Science Student',
            // ),
            AboutUsTile(
              pic: 'shah.jpeg',
              name: 'Syed',
              subName: 'Muhammad Nawaz Shah',
              position: 'Developer',
              description: 'CUI Computer Science Student',
            ),

            // AboutUsTile(
            //   pic: 'ramay.JPG',
            //   name: 'Hamza',
            //   subName: 'Rafique Ramay',
            //   position: 'Developer',
            //   description: 'CUI Computer Science Student',
            // ),
          ],
        ),
      ),
    );
  }
}
