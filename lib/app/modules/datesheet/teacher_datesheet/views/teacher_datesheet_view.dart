import 'widgets/teacher_datesheet_widgets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/teacher_datesheet_controller.dart';

class TeacherDatesheetView extends GetView<TeacherDatesheetController> {
  final days = {
    "monday": "Mon",
    "tuesday": "Tue",
    "wednesday": "Wed",
    "thursday": "Thu",
    "friday": "Fri",
    "saturday": "Sat",
    "sunday": "Sun"
  };
  TeacherDatesheetView({Key? key}) : super(key: key);

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
                            debugPrint(days[controller.datesForDayList[index][0]
                                .toString()
                                .toLowerCase()]!);
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
                                    'No Duty Today',
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
                                  // return Card(
                                  //   child: Text('hllleljasdlf'),
                                  // );
                                  return LectureDetailsTile(
                                    date:
                                        "${controller.currentDayPapers[index][3]}",
                                    time: controller.currentDayPapers[index][4]
                                        .toString()
                                        .replaceAll("00", ":00"),
                                    room: controller.currentDayPapers[index][5]
                                        .toString(),
                                    subject: controller.currentDayPapers[index]
                                            [7]
                                        .toString(),
                                    sections: controller.currentDayPapers[index]
                                            [6]
                                        .toString()
                                        .replaceAll("#", ", "),
                                  );
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
