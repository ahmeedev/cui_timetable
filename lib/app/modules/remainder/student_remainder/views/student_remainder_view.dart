import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cui_timetable/app/modules/remainder/student_remainder/views/widgets/student_remainder_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/student_remainder_controller.dart';

class StudentRemainderView extends GetView<StudentRemainderController> {
  const StudentRemainderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments["section"]),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await AwesomeNotifications().cancelAllSchedules();
                },
                icon: const Text("Click me"))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            children: [
              Obx(() => Card(
                    color: controller.allSet.value == true
                        ? errorColor1
                        : successColor,
                    // color: widgetColor,
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              controller.allSet.value == true
                                  ? "Revoke all the slots from remainder?"
                                  : "Set all the slots as remainder?",
                              style: textTheme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          controller.allSet.value == false
                              ? AbsorbPointer(
                                  absorbing: controller.absorbing.value,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // log("${controller.sectionDetails.toList()}");
                                        controller.setAll();
                                      },
                                      child: const Text('Set All')),
                                )
                              : AbsorbPointer(
                                  absorbing: controller.absorbing.value,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // log("${controller.sectionDetails.toList()}");
                                        controller.revokeAll();
                                      },
                                      // style: ElevatedButton.styleFrom(
                                      //     primary: errorColor1),
                                      child: const Text('Revoke All')),
                                )
                        ],
                      ),
                    ),
                  )),
              kHeight,
              Obx(() => controller.absorbing.value
                  ? SpinKitThreeBounce(
                      color: primaryColor,
                      size: Constants.iconSize,
                    )
                  : const SizedBox()),
              Obx(() => controller.futureStatus.value == false
                  ? const Expanded(
                      child: Center(
                        child: SpinKitPouringHourGlass(
                          color: primaryColor,
                        ),
                      ),
                    )
                  : Expanded(
                      child: FutureBuilder<Map>(
                          // stream: null,
                          future: controller.future,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SpinKitPouringHourGlass(
                                color: primaryColor,
                              );
                            }
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!["filteredData"].length,
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(() => LectureDetailsTile(
                                      subject: snapshot.data!["filteredData"]
                                          [index][0],
                                      teacher: snapshot.data!["filteredData"]
                                          [index][1],
                                      counter: index + 1,
                                      isSet:
                                          // snapshot.data!["notiRemainder"][index] == 0
                                          controller.notiRemainder[index] == 0
                                              ? false
                                              : true,
                                      // isSet: false,
                                    ));
                              },
                            );
                          }),
                    )),
            ],
          ),
        ));
  }
}
