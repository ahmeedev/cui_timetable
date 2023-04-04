import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../widgets/about_us_tile.dart';
import '../controllers/contributions_controller.dart';

class ContributionsView extends GetView<ContributionsController> {
  const ContributionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contribution'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Text(
                    "Thank you for choosing our timetable application to help manage your time more effectively. As a student of COMSATS University Islamabad, Sahiwal Campus, we understand the importance of having a reliable tool to manage your busy schedule. As a free application, we rely on the support of our users to continue improving and providing the best service possible. We appreciate any contributions that you are able to make to help us achieve our goals. Your support will help us to continue to provide valuable features to all users of our application, including the students of COMSATS University Islamabad, Sahiwal Campus. If you're interested in contributing, please feel free to contact our software house for more information. Thank you for your generosity and for being a part of our community.",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              kHeight,
              Card(
                  color: primaryColor.withOpacity(0.8),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constants.defaultRadius / 2))),
                  margin: EdgeInsets.zero,
                  child: Text(
                    "Our Team",
                    style: theme.textTheme.titleSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ).paddingAll(Constants.defaultPadding)
                  // .paddingSymmetric(horizontal: Constants.defaultPadding),
                  ),
              // kHeight,
              const AboutUsTile(
                pic: 'ahmad.png',
                name: 'Ahmad Tariq',
                subName: '',
                position: 'Developer',
                description: 'CUI Computer Science Student',
                isProminent: true,
              ),
              const AboutUsTile(
                pic: 'shah.jpeg',
                name: 'Syed',
                subName: 'Muhammad Nawaz Shah',
                position: 'Developer',
                description: 'CUI Computer Science Student',
              ),

              const AboutUsTile(
                pic: 'rao.jpg',
                name: 'Rao',
                subName: 'Muhammad Bilal',
                position: 'UI / UX',
                description: 'CUI Computer Science Student',
              ),
            ],
          ),
        ));
  }
}
