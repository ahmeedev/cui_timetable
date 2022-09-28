import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'widgets/student_timetable_widgets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';

import '../controllers/student_timetable_controller.dart';

class StudentTimetableView extends GetView<StudentTimetableController> {
  StudentTimetableView({Key? key}) : super(key: key);

  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final keys = ['10000', '1000', '100', '10', '1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[0]),
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
                    stream: controller.stream,
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
                              day: days[index].toString(),
                              dayKey: keys[index].toString(),
                              callback: controller.allFalse,
                              obs: controller.giveValue(index),
                            );
                          })
                        ]);
                      }
                    }),
              ),
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
                                  String time = _fetchNewTime(index: index);
                                  return LectureDetailsTile(
                                      lab: true,
                                      subject: controller
                                          .daywiseLectures["lectures"][index]
                                          .subject,
                                      teacher: controller
                                          .daywiseLectures["lectures"][index]
                                          .teacher,
                                      room: controller
                                          .daywiseLectures["lectures"][index]
                                          .room,
                                      time: time);
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return LectureDetailsTile(
                                    subject: controller
                                        .daywiseLectures["lectures"][index]
                                        .subject,
                                    teacher: controller
                                        .daywiseLectures["lectures"][index]
                                        .teacher,
                                    room: controller
                                        .daywiseLectures["lectures"][index]
                                        .room,
                                    time: controller.currentTimeSlots[controller
                                                .daywiseLectures["lectures"]
                                                    [index]
                                                .slot -
                                            1]
                                        .toString());
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
