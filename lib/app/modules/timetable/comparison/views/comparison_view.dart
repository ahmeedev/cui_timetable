import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'widgets/comparison_widgets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';

import '../controllers/comparison_controller.dart';

class ComparisonView extends GetView<ComparisonController> {
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final keys = ['10000', '1000', '100', '10', '1'];

  ComparisonView({Key? key}) : super(key: key);

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
                          ...List.generate(5, (index) {
                            return DayTile(
                              day: days[index].toString(),
                              dayKey: keys[index].toString(),
                              callback: controller.allFalse,
                              obs: controller.giveValue(index),
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
                  child: Column(
                    children: [
                      Card(
                        child: Container(
                          // color: widgetColor,
                          decoration: BoxDecoration(
                              color: widgetColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Constants.defaultRadius))),
                          padding: EdgeInsets.all(Constants.defaultPadding / 2),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                'MakeUp classes available for',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(
                                height: Constants.defaultPadding / 2,
                              ),
                              Text(
                                Get.arguments[1].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: Constants.lectureFlex,
                        child: Obx(() => FractionallySizedBox(
                              widthFactor: 1,
                              heightFactor: 1,
                              child: controller.daywiseLectures.isEmpty
                                  ? Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          'No Free Slots',
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
                                          controller.daywiseLectures.length,
                                      itemBuilder: (context, index) {
                                        return LectureDetailsTile(
                                            time: controller
                                                .currentTimeSlots[index]
                                                .toString());
                                        // return LectureDetailsTile(
                                        //     subject: controller.daywiseLectures[index][1],
                                        //     teacher: controller.daywiseLectures[index][4],
                                        //     room: controller.daywiseLectures[index][5],
                                        // time: controller.currentTimeSlots[int.parse(
                                        //             controller.daywiseLectures[index]
                                        //                     [2]
                                        //                 .toString()) -
                                        //         1]
                                        //     .toString());
                                      },
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
