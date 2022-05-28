import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/freerooms/views/widgets/freerooms_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/freerooms_controller.dart';

class FreeroomsView extends GetView<FreeroomsController> {
  FreeroomsView({Key? key}) : super(key: key);
  final daysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final daysKeys = [
    DBFreerooms.monday,
    DBFreerooms.tuesday,
    DBFreerooms.wednesday,
    DBFreerooms.thursday,
    DBFreerooms.friday,
  ];
  final slots = [
    "08:30AM - 10:00AM",
    "10:00AM - 11:30AM",
    "11:30AM - 01:00PM",
    "01:30PM - 3:00PM",
    "03:00PM - 04:30PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Free Rooms'),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Row(children: [
                  ...List.generate(5, (index) {
                    return DayTile(
                      day: daysList[index],
                      dayKey: daysKeys[index],
                      callback: controller.allFalse,
                      obs: controller.giveValue(index),
                    );
                  })
                ]),
              ),
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            Flexible(
              flex: Constants.lectureFlex,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: FutureBuilder(
                  future: controller.fetchDetails(),
                  // initialData: initialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SpinKitFadingCircle(
                            size: 50,
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: Constants.defaultPadding,
                          ),
                          Text(
                            'Fetching Rooms From Database...',
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: 1,
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.defaultPadding / 2),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return FreeroomsMainExpansionTile(
                              slot: controller.currentSecreenTime[index],
                              totalClasses:
                                  controller.currentScreenSlot1Classes.length,
                              expanded: index == 0 ? true : false);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
