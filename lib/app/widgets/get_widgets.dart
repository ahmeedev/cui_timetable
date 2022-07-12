import 'dart:io';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/timetable/controllers/student_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:hive/hive.dart';

// Dart imports:

// Flutter imports:

// Package imports:

// Project imports:

class GetXUtilities {
  static void snackbar(
      {required String title, required String message, required gradient}) {
    Get.closeAllSnackbars();

    if (Platform.isAndroid) {
      Get.showSnackbar(GetSnackBar(
        // backgroundColor: primaryColor,
        // padding: EdgeInsets.all(Constants.defaultPadding),

        margin: EdgeInsets.zero,
        backgroundGradient:
            LinearGradient(end: Alignment.bottomRight, colors: gradient),

        duration: const Duration(seconds: 2),
        titleText: Text(title,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        messageText: Text(message,
            style: const TextStyle(fontSize: 14, color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        // backgroundColor: primaryColor,
      ));
    } else if (Platform.isIOS) {
      Get.snackbar(
        "Default SnackBar",
        "This is the Getx default SnackBar",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1500),
        titleText: Text(title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        messageText: Text(message,
            style: const TextStyle(fontSize: 12, color: Colors.black)),
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
        content: AspectRatio(
          aspectRatio: 8 / 3,
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
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
        titleStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
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

                          box2.delete(DBTimetableCache.history);
                          box2.put(DBTimetableCache.history, content.value);
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
                                                DBTimetableCache.history,
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
                                                DBTimetableCache.history, list);
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
}
