import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'widgets/student_datesheet_widgets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';

import '../controllers/student_datesheet_controller.dart';

class StudentDatesheetView extends GetView<StudentDatesheetController> {
  final days = {
    "monday": "Mon",
    "tuesday": "Tue",
    "wednesday": "Wed",
    "thursday": "Thu",
    "friday": "Fri",
    "saturday": "Sat",
    "sunday": "Sun"
  };
  // final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday','Saturday','Sunday'];
  // final respectiveDay = ['Mon', 'Tues', 'Wed','Thrus', 'Fri', 'Sat', 'Sun'];

  StudentDatesheetView({Key? key}) : super(key: key);

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
                  child: Obx((() => controller.isLoading.value
                      ? const SpinKitFadingCircle(
                          color: primaryColor,
                        )
                      : Row(children: [
                          ...List.generate(controller.daytilesLength, (index) {
                            return DayTile(
                              day: days[controller.datesForDayList[index][0]
                                  .toString()
                                  .toLowerCase()]!,
                              index: index.toString(), //! index as key
                              date: controller.datesForDayList[index][1],
                              callback: controller.allFalse,
                              stateVariable: controller.dayTilesSelection[
                                  controller.datesForDayList[index][1]]!,
                            );
                          })
                        ])))),
            ),
            Flexible(
              flex: Constants.lectureFlex,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Obx(() => FractionallySizedBox(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: controller.currentDayPapers.isEmpty
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
                                    'No Paper Today',
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
                                itemCount: controller.currentDayPapers.length,
                                itemBuilder: (context, index) {
                                  return LectureDetailsTile(
                                      date:
                                          "${controller.currentDayPapers[index][3]}",
                                      subject: controller
                                          .currentDayPapers[index][6]
                                          .toString(),
                                      room: controller.currentDayPapers[index]
                                              [5]
                                          .toString(),
                                      time: controller.currentDayPapers[index]
                                              [4]
                                          .toString());
                                  // return LectureDetailsTile(
                                  //     date: "${controller.papers[index][2]}",
                                  //     subject: controller.papers[index][2]
                                  //         .toString(),
                                  //     room: controller.papers[index][2]
                                  //         .toString(),
                                  //     time: controller.papers[index][2]
                                  //         .toString());
                                },
                              ),
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
