import 'dart:math';

import 'package:cui_timetable/app/modules/datesheet/teacher_datesheet/controllers/teacher_datesheet_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class DayTile extends GetView<TeacherDatesheetController> {
  late final String day;
  late final String index;
  late final String date;
  late final Function callback;

  late final stateVariable;
  final colorList = [
    Colors.purple,
    Colors.amber,
    Colors.red,
    Colors.black,
    Colors.orange,
    Colors.purple,
    Colors.amber,
    Colors.red,
    Colors.black,
    Colors.orange,
    Colors.purple,
    Colors.amber,
    Colors.red,
    Colors.black,
    Colors.orange,
  ];

  DayTile({
    required this.day,
    required this.index,
    required this.date,
    required this.callback,
    required this.stateVariable,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: 1,
          child: Obx(() => Card(
              color: widgetColor,
              shadowColor: shadowColor,
              elevation: stateVariable
                  ? Constants.defaultElevation
                  : Constants.defaultElevation / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.defaultRadius)),
              child: Container(
                decoration: BoxDecoration(
                    color: stateVariable ? selectionColor : widgetColor,
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius)),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(Constants.defaultRadius),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius),
                    onTap: () {
                      controller.getPapers(date: date);
                      controller.giveValue(date: date);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(day,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          controller.datesForDayList[int.parse(index)][1]
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            ...List.generate(
                                controller.lecturesCount[date]!,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: colorList[index],
                                            shape: BoxShape.circle),
                                      ),
                                    ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )))),
    );
  }
}

class LectureDetailsTile extends StatelessWidget {
  final String sections;
  final String subject;
  final String date;
  final String room;
  final dynamic time;

  const LectureDetailsTile(
      {Key? key,
      required this.sections,
      required this.subject,
      required this.date,
      required this.room,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Constants.defaultPadding / 2, 0,
          Constants.defaultPadding / 2, Constants.defaultPadding / 2),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Constants.defaultPadding / 2,
                  right: Constants.defaultPadding / 2,
                  top: Constants.defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius)),
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: Text(
                        date.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize! +
                                    2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constants.defaultPadding,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius)),
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: Text(
                        sections.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize! +
                                    2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constants.defaultPadding,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius)),
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: Text(
                        subject.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize! +
                                    2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constants.defaultPadding * 2,
                  ),
                  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/home/room.png'),
                        color: primaryColor,
                      ),
                      const SizedBox(width: 5),
                      Text(room.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const ImageIcon(
                        AssetImage('assets/freerooms/timer.png'),
                        color: primaryColor,
                      ),
                      const SizedBox(width: 5),
                      FittedBox(
                        child: Text(time.toString(),
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
