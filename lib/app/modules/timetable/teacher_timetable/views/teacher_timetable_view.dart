// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:cui_timetable/app/modules/timetable/teacher_timetable/controllers/teacher_timetable_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

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
                    child: controller.daywiseLectures.isEmpty
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
                            itemCount: controller.daywiseLectures.length,
                            itemBuilder: (context, index) {
                              return LectureDetailsTile(
                                section: controller.daywiseLectures[index][0],
                                subject: controller.daywiseLectures[index][1],
                                room: controller.daywiseLectures[index][5],
                                time: int.parse(
                                            "${controller.daywiseLectures[index][2]}") ==
                                        5
                                    ? controller.friSlots[int.parse(
                                            "${controller.daywiseLectures[index][2]}") -
                                        1]
                                    : controller.monToThursSlots[int.parse(
                                            "${controller.daywiseLectures[index][2]}") -
                                        1],
                              );
                            },
                          ),
                  )),
            ),
          ],
        ));
  }
}

class DayTile extends GetView<TeacherTimetableController> {
  // late final TeacherTimetableController controller;
  late final String day;
  late final String dayKey;
  late final Function callback;

  late final Rx<bool> obs;
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
    required this.dayKey,
    required this.callback,
    required this.obs,
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
              elevation: obs.value
                  ? Constants.defaultElevation
                  : Constants.defaultElevation / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.defaultRadius)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: obs.value ? selectionColor : widgetColor,
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius)),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(Constants.defaultRadius),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius),
                    onTap: () {
                      callback();
                      controller.getLectures(key: dayKey.toString());
                      obs.value = true;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(day,
                            style: Theme.of(context).textTheme.titleMedium),
                        controller.lecturesCount[dayKey] == "null"
                            ? const SpinKitFadingCircle(
                                size: 50,
                                color: primaryColor,
                              )
                            : Text(
                                controller.lecturesCount[dayKey].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                        int.parse(controller.lecturesCount[dayKey.toString()]
                                    .toString()) ==
                                0
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.defaultPadding * 2.5),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: successGradient)),
                                ),
                              )
                            : Wrap(
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
                ),
              )))),
    );
  }
}

class LectureDetailsTile extends StatelessWidget {
  final dynamic time;
  final String subject;
  final String room;
  final String section;

  const LectureDetailsTile(
      {Key? key,
      required this.subject,
      required this.section,
      required this.room,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Constants.defaultPadding / 2, 0,
          Constants.defaultPadding / 2, Constants.defaultPadding / 2),
      child: Card(
        color: widgetColor,
        elevation: Constants.defaultElevation,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius))),
        child: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      time.toString().split('-')[0],
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text('|'),
                    const Text('|'),
                    Text(
                      time.toString().split('-')[1],
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const VerticalDivider(
                  color: primaryColor,
                  thickness: 2.0,
                  // indent: 4,
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
                              color: textFieldColor,
                              borderRadius: BorderRadius.circular(
                                  Constants.defaultRadius)),
                          child: Padding(
                            padding: EdgeInsets.all(Constants.defaultPadding),
                            child: Text(subject.toString(),
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
                                            2)),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
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
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const ImageIcon(
                              AssetImage('assets/timetable/professor.png'),
                              color: primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(section.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
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
