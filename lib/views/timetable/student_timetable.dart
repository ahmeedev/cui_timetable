import 'package:cui_timetable/controllers/timetable/student_timetable_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class StudentTimetable extends StatelessWidget {
  StudentTimetable({Key? key}) : super(key: key);
  final studentTimetableController = Get.put(StudentTimetableController());
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final keys = ['10000', '1000', '100', '10', '1'];
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    return Scaffold(
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
                    stream: studentTimetableController.openBox(
                        section: arguments[0]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const GFLoader();
                      } else {
                        return Row(children: [
                          ...List.generate(5, (index) {
                            return DayTile(
                              controller: studentTimetableController,
                              day: days[index],
                              dayKey: keys[index],
                              callback: studentTimetableController.allFalse,
                              obs: studentTimetableController.giveValue(index),
                            );
                          })
                        ]);
                      }
                    }),
              ),
            ),
            Flexible(
              flex: 6,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Obx(() => ListView.builder(
                      itemCount:
                          studentTimetableController.daywiseLectures.length,
                      itemBuilder: (context, index) {
                        return LectureDetailsTile(
                          subject: studentTimetableController
                              .daywiseLectures[index][0],
                          teacher: studentTimetableController
                              .daywiseLectures[index][3],
                          room: studentTimetableController
                              .daywiseLectures[index][4],
                          time: studentTimetableController.timeMap[
                              "${studentTimetableController.daywiseLectures[index][1]}"],
                        );
                      },
                    )),
              ),
            ),
          ],
        ));
  }
}

class DayTile extends StatelessWidget {
  DayTile(
      {required this.day,
      required this.dayKey,
      required this.callback,
      required this.obs,
      Key? key,
      required this.controller})
      : super(key: key);
  late StudentTimetableController controller;
  late final day;
  late final dayKey;
  late final callback;
  late Rx<bool> obs;
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

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      heightFactor: 0.8,
      widthFactor: 1,
      child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      color: obs.value ? Colors.grey.shade300 : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        callback();
                        controller.getLectures(key: dayKey.toString());
                        obs.value = true;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(day),
                          controller.lecturesCount[dayKey] == "null"
                              ? const GFLoader()
                              : Text(
                                  controller.lecturesCount[dayKey].toString()),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ...List.generate(
                                  int.parse(controller
                                      .lecturesCount[dayKey.toString()]
                                      .toString()),
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
                    color: Colors.transparent,
                  ),
                )),
          )),
    ));
  }
}

class LectureDetailsTile extends StatelessWidget {
  late final subject;
  late final teacher;
  late final room;
  late final time;

  LectureDetailsTile(
      {Key? key,
      required this.subject,
      required this.teacher,
      required this.room,
      this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(time[0]), const Text('|'), Text(time[1])],
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 2.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              subject.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.place),
                            const SizedBox(width: 5),
                            Text(room.toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.school),
                            const SizedBox(width: 5),
                            Text(teacher.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
