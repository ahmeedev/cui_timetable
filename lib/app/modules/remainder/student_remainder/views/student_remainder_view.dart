import 'package:cui_timetable/app/modules/remainder/student_remainder/views/widgets/student_remainder_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

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
        ),
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            children: [
              Card(
                color: successColor,
                child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Set all the slots as remainder?",
                        style: textTheme.titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Set All'))
                    ],
                  ),
                ),
              ),
              kHeight,
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ...List.generate(
                        5,
                        (index) => LectureDetailsTile(
                              time: "09:00 - 10:00",
                            )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
