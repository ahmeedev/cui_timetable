import '../controllers/teacher_timetable_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'widgets/teacher_timetable_widgets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';

class TeacherTimetableView extends GetView<TeacherTimetableController> {
  TeacherTimetableView({Key? key}) : super(key: key);
  // final teacherTimetableController = Get.put(TeacherTimetableController());

  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final keys = ['10000', '1000', '100', '10', '1'];
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[0]),
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          // ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: StreamBuilder(
                    stream: controller.openBox(teacher: arguments[0]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SpinKitFadingCircle(
                          size: 50,
                          color: primaryColor,
                        );
                      } else {
                        return Row(children: [
                          ...List.generate(5, (index) {
                            return DayTile(
                              day: days[index],
                              dayKey: keys[index],
                              callback: controller.allFalse,
                              obs: controller.giveValue(index),
                            );
                          })
                        ]);
                      }
                    }),
              ),
            ),
            SizedBox(
              height: Constants.defaultPadding / 2,
            ),
            Flexible(
              flex: Constants.lectureFlex,
              child: Obx(() => FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: controller.daywiseLectures["lectures"] == null ||
                            controller.daywiseLectures["lectures"].isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ImageIcon(
                                AssetImage(
                                    'assets/timetable/free_lectures.png'),
                                size: 150,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No Lecture Today',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w900,
                                      // fontSize:
                                    ),
                              )
                            ],
                          ))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                controller.daywiseLectures["lectures"].length,
                            itemBuilder: (context, index) {
                              if (controller.daywiseLectures["combineIndexes"]
                                  .contains(index)) {
                                if (controller
                                    .daywiseLectures["actualTileIndexes"]
                                    .contains(index)) {
                                  if (controller
                                          .daywiseLectures["subjectAndTime"] ==
                                      true) {
                                    return LectureDetailsTile(
                                      lab: true,
                                      section: controller
                                              .daywiseLectures["lectures"]
                                                  [index]
                                              .section +
                                          ",\n" +
                                          controller
                                              .daywiseLectures["lectures"]
                                                  [index + 1]
                                              .section,
                                      subject: controller
                                          .daywiseLectures["lectures"][index]
                                          .subject,
                                      room: controller
                                          .daywiseLectures["lectures"][index]
                                          .room,
                                      time: controller
                                          .currentTimeSlots[int.parse(controller
                                                  .daywiseLectures["lectures"]
                                                      [index]
                                                  .slot
                                                  .toString()) -
                                              1]
                                          .toString(),
                                    );
                                  }
                                  // subjectAndSection=true
                                  String time = _fetchNewTime(index: index);
                                  return LectureDetailsTile(
                                      lab: true,
                                      section: controller
                                          .daywiseLectures["lectures"][index]
                                          .section,
                                      subject: controller
                                          .daywiseLectures["lectures"][index]
                                          .subject,
                                      room: controller
                                          .daywiseLectures["lectures"][index]
                                          .room,
                                      time: time);

                                  // String time = _fetchNewTime(index: index);

                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return LectureDetailsTile(
                                  section: controller
                                      .daywiseLectures["lectures"][index]
                                      .section,
                                  subject: controller
                                      .daywiseLectures["lectures"][index]
                                      .subject,
                                  room: controller
                                      .daywiseLectures["lectures"][index].room,
                                  time: controller.currentTimeSlots[int.parse(
                                              controller
                                                  .daywiseLectures["lectures"]
                                                      [index]
                                                  .slot
                                                  .toString()) -
                                          1]
                                      .toString(),
                                );
                              }
                            },
                          ),
                  )),
            ),
          ],
        ));
  }

  String _fetchNewTime({required index}) {
    final time1 = controller.currentTimeSlots[int.parse(
                controller.daywiseLectures["lectures"][index].slot.toString()) -
            1]
        .toString()
        .split('-');
    final time2 = controller.currentTimeSlots[int.parse(
            controller.daywiseLectures["lectures"][index].slot.toString())]
        .toString()
        .split("-");

    return '${time1[0].trim()}-${time2[1].trim()}';
  }
}
