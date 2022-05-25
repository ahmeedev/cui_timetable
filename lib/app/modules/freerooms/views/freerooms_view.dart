import 'package:cui_timetable/app/modules/freerooms/views/widgets/freerooms_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/freerooms_controller.dart';

class FreeroomsView extends GetView<FreeroomsController> {
  FreeroomsView({Key? key}) : super(key: key);
  final daysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final slots = [
    "08:30AM - 10:00AM",
    "10:00AM - 11:30AM",
    "11:30AM - 01:00PM",
    "01:30PM - 3:00PM",
    "03:00PM - 04:30PM"
  ];

  //* Testing list
  final nORooms = [3, 2, 1, 4, 3];

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
                      callback: controller.allFalse,
                      obs: controller.giveValue(index),
                    );
                  })
                ]),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Flexible(
              flex: 6,
              child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: ListView(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        FreeroomsMainExpansionTile(
                            slot: '10:00AM - 11:00AM', expanded: true),
                        FreeroomsMainExpansionTile(
                            slot: '11:00AM - 12:00PM', expanded: false),
                        FreeroomsMainExpansionTile(
                            slot: '02:00PM - 03:00PM', expanded: false),
                        FreeroomsMainExpansionTile(
                            slot: '03:00PM - 04:00PM', expanded: false),
                        FreeroomsMainExpansionTile(
                            slot: '12:00PM - 01:00PM', expanded: false),
                      ])),
            ),
          ],
        ));
  }
}
