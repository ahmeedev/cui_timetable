import 'dart:io';

import '../data/database/database_constants.dart';
import '../modules/timetable/controllers/student_ui_controller.dart';
import '../modules/remainder/controllers/student_ui_controlller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import 'package:hive/hive.dart';

class GetXUtilities {
  static void snackbar(
      {required String title,
      required String message,
      required gradient,
      duration = 2}) {
    Get.closeAllSnackbars();

    if (Platform.isIOS) {
      Get.showSnackbar(GetSnackBar(
        // backgroundColor: primaryColor,
        // padding: EdgeInsets.all(Constants.defaultPadding),

        margin: const EdgeInsets.all(16),
        // backgroundGradient:
        //     LinearGradient(end: Alignment.bottomRight, colors: gradient),
        backgroundColor: scaffoldColor,
        borderRadius: Constants.defaultRadius,
        padding: const EdgeInsets.all(20),
        duration: Duration(seconds: duration),
        titleText: Text(title,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        messageText: Text(message,
            style: const TextStyle(fontSize: 14, color: Colors.black)),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        // backgroundColor: primaryColor,
      ));
    } else if (Platform.isIOS) {
      // Get.snackbar("Hello", "Message");
      // Get.showSnackbar(GetSnackBar(
      //   // backgroundColor: primaryColor,
      //   // padding: EdgeInsets.all(Constants.defaultPadding),

      //   margin: EdgeInsets.zero,
      //   backgroundGradient:
      //       LinearGradient(end: Alignment.bottomRight, colors: gradient),

      //   duration: Duration(seconds: duration),
      //   titleText: const Text("Hello",
      //       style: TextStyle(
      //           fontSize: 18,
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold)),
      //   messageText: Text(message,
      //       style: const TextStyle(fontSize: 14, color: Colors.white)),
      //   snackPosition: SnackPosition.BOTTOM,
      //   snackStyle: SnackStyle.GROUNDED,
      //   // backgroundColor: primaryColor,
      // ));

      Get.snackbar(
        "Default SnackBar",
        "This is the Getx default SnackBar",

        // snackPosition: SnackPosition.BOTTOM,
        // duration: Duration(milliseconds: duration)
        // ,
        titleText: Text(title,
            style: const TextStyle(
                fontSize: 16,
                // color: primaryColor,
                fontWeight: FontWeight.bold)),
        messageText: Text(message,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      );
    }
  }

  //! Use Context for the automation of theme.
  static void dialog() {
    Get.defaultDialog(
        onWillPop: () => Future.value(false),
        // title: 'Synchronizing',
        title: '',
        // titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
        //     color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        titlePadding: EdgeInsets.zero,
        barrierDismissible: false,
        backgroundColor: widgetColor,
        contentPadding: EdgeInsets.all(Constants.defaultPadding),
        radius: Constants.defaultRadius * 2,
        content: const AspectRatio(
          aspectRatio: 8 / 3,
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Sync in Progress",
                // style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //     color: Colors.black,
                //     fontSize: 20,
                //     fontStyle: FontStyle.italic,
                //     fontWeight: FontWeight.bold),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              SpinKitWave(
                color: primaryColor,
                size: 40,
              )
              // const LinearProgressIndicator(
              //   color: primaryColor,
              // )
            ],
          )),
        ));
  }

  static void historyDialog(
      {required context, required content, required bool student}) {
    Get.defaultDialog(
        backgroundColor: widgetColor,
        titlePadding: EdgeInsets.all(Constants.defaultPadding),
        title: 'History',
        titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! + 2,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        contentPadding: EdgeInsets.all(Constants.defaultPadding),
        content: content.isEmpty
            ? const Text('No Record yet')
            : SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Obx(() => ReorderableListView(
                        physics: const BouncingScrollPhysics(),
                        onReorder: (oldIndex, newIndex) async {
                          if (newIndex > oldIndex) newIndex--;
                          final item = content.value.removeAt(oldIndex);
                          content.insert(newIndex, item);
                          final box2 =
                              await Hive.openBox(DBNames.timetableCache);
                          if (student) {
                            box2.delete(DBTimetableCache.studentHistory);
                            box2.put(
                                DBTimetableCache.studentHistory, content.value);
                          } else {
                            box2.delete(DBTimetableCache.teacherHistory);
                            box2.put(
                                DBTimetableCache.teacherHistory, content.value);
                          }
                        },
                        children: [
                          ...List.generate(
                              content.length,
                              (index) => Row(
                                    key: ValueKey(content[index]),
                                    children: [
                                      Flexible(
                                        child: ListTile(
                                          onTap: () {
                                            // Get.back();
                                            if (student) {
                                              Get.toNamed(
                                                  Routes.STUDENT_TIMETABLE,
                                                  arguments: [content[index]]);
                                            } else {
                                              Get.toNamed(
                                                  Routes.TEACHER_TIMETABLE,
                                                  arguments: [content[index]]);
                                            }
                                          },
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          leading: Text(
                                            content[index].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (student) {
                                            final box2 = await Hive.openBox(
                                                DBNames.timetableCache);

                                            List list = box2.get(
                                                DBTimetableCache.studentHistory,
                                                defaultValue: []);

                                            list.removeAt(index);

                                            Get.find<StudentUIController>()
                                                .dialogHistoryList
                                                .value = [];

                                            for (var element in list) {
                                              Get.find<StudentUIController>()
                                                  .dialogHistoryList
                                                  .add(element);
                                            }

                                            box2.put(
                                                DBTimetableCache.studentHistory,
                                                list);
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: errorColor1,
                                          size: Constants.iconSize - 6,
                                        ),
                                      ),
                                    ],
                                  ))
                        ]
                        // },
                        // separatorBuilder: (context, index) {
                        //   return const Divider(
                        //     color: primaryColor,
                        //     height: 1,
                        //     thickness: 1,
                        //     // indent: 15,
                        //     // endIndent: 15,
                        // );
                        //   },
                        // ))),
                        ))));
  }

  static void remainderHistory(
    context, {
    required content,
  }) {
    Get.defaultDialog(
        backgroundColor: widgetColor,
        titlePadding: EdgeInsets.all(Constants.defaultPadding),
        title: 'Scheduled sections',
        titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! + 2,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        contentPadding: EdgeInsets.all(Constants.defaultPadding),
        content: content.isEmpty
            ? const Text('No Record yet')
            : SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Obx(() => ReorderableListView(
                        physics: const BouncingScrollPhysics(),
                        onReorder: (oldIndex, newIndex) async {
                          if (newIndex > oldIndex) newIndex--;
                          final item = content.value.removeAt(oldIndex);
                          content.insert(newIndex, item);
                          final box2 =
                              await Hive.openBox(DBNames.remainderCache);

                          box2.delete(DBRemainderCache.sectionHistory);
                          box2.put(
                              DBRemainderCache.sectionHistory, content.value);
                        },
                        children: [
                          ...List.generate(
                              content.length,
                              (index) => Row(
                                    key: ValueKey(content[index]),
                                    children: [
                                      Flexible(
                                        child: ListTile(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.STUDENT_REMAINDER,
                                                arguments: {
                                                  "section": content[index]
                                                });
                                          },
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          leading: Text(
                                            content[index].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final box2 = await Hive.openBox(
                                              DBNames.remainderCache);

                                          List list = box2.get(
                                              DBRemainderCache.sectionHistory,
                                              defaultValue: []);

                                          list.removeAt(index);

                                          Get.find<
                                                  RemainderStudentUIController>()
                                              .sectionHistory
                                              .value = [];

                                          for (var element in list) {
                                            Get.find<
                                                    RemainderStudentUIController>()
                                                .sectionHistory
                                                .add(element);
                                          }

                                          box2.put(
                                              DBRemainderCache.sectionHistory,
                                              list);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: errorColor1,
                                          size: Constants.iconSize - 6,
                                        ),
                                      ),
                                    ],
                                  ))
                        ]
                        // },
                        // separatorBuilder: (context, index) {
                        //   return const Divider(
                        //     color: primaryColor,
                        //     height: 1,
                        //     thickness: 1,
                        //     // indent: 15,
                        //     // endIndent: 15,
                        // );
                        //   },
                        // ))),
                        ))));
  }
}
