// Dart imports:
import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:csv/csv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

// Project imports:
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';

Future<void> downloadFile({
  required String fileName,
  required callback,
  csv = true,
}) async {
  final storageRef = FirebaseStorage.instance.ref();
  final islandRef = storageRef.child(fileName);
  final filePath = "${LocationUtilities.defaultpath}/$fileName";
  final file = File(filePath);

  final downloadTask = islandRef.writeToFile(file);
  downloadTask.snapshotEvents.listen((taskSnapshot) async {
    switch (taskSnapshot.state) {
      case TaskState.running:
        devlog.log("Start Downloading...", name: fileName.toUpperCase());
        break;
      case TaskState.paused:
        devlog.log("File Downloading Paused Unexpectedly...",
            name: fileName.toUpperCase());
        break;
      case TaskState.success:
        if (csv) {
          compute(_backgroundTaskCsv, {
            "filePath": LocationUtilities.defaultpath,
            "fileName": fileName,
            "callback": callback
          }).then((value) => _updateStatuses());
        } else {
          compute(_backgroundTaskJson, {
            "filePath": LocationUtilities.defaultpath,
            "fileName": fileName,
            "callback": callback
          });
        }

        devlog.log("File Downloaded Successfully...",
            name: fileName.toUpperCase());
        break;
      case TaskState.canceled:
        devlog.log("File Downloading Cancelled...",
            name: fileName.toUpperCase());
        break;
      case TaskState.error:
        devlog.log("File Downloading Cancelled...",
            name: fileName.toUpperCase());
        break;
    }
  });
}

_backgroundTaskCsv(map) async {
  await _getCsvFileContent(
          fileLocation: map["filePath"], fileName: map["fileName"])
      .then((data) => map["callback"](filePath: map['filePath'], data: data));
}

_backgroundTaskJson(map) async {
  await _getJsonFileContent(
          fileLocation: map["filePath"], fileName: map["fileName"])
      .then((data) => map["callback"](filePath: map['filePath'], data: data));
}

Future<List<dynamic>> _getCsvFileContent(
    {required String fileLocation, required String fileName}) async {
  dynamic fields;
  try {
    final File file = File('$fileLocation/$fileName');
    final input = file.openRead();
    fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    devlog.log("File Read Successfully With Records Count: ${fields.length}",
        name: "SYNC_READ");
  } catch (e) {
    debugPrint(e.toString());
    devlog.log("Error!, While file Reading... ", name: "SYNC_READ");
  } finally {
    // Isolate.exit(port, map);

  }
  return Future<List<dynamic>>.value(fields);
}

Future<String> _getJsonFileContent(
    {required String fileLocation, required String fileName}) async {
  dynamic fields;
  try {
    final File file = File('$fileLocation/$fileName');
    final input = file.readAsString();
    fields = input;
    // print(input);
    // devlog.log("File Read Successfully With Records Count: ${fields.length}",
    //     name: "SYNC_READ");
  } catch (e) {
    debugPrint(e.toString());
    devlog.log("Error!, While file Reading... ", name: "SYNC_READ");
  } finally {
    // Isolate.exit(port, map);

  }
  return fields;
}

//! run in main thread.
_updateStatuses() async {
  final box1 = await Hive.openBox(DBNames.info);
  bool newUser = box1.get(DBInfo.newUser, defaultValue: true);
  if (newUser) {
    box1.put(DBInfo.newUser, false);
    Get.back();
  }
  final String lastUpdate = Jiffy().format("MMMM do yyyy");
  box1.put(DBInfo.lastUpdate, lastUpdate);

  await getRemoteVersion().then((value) {
    box1.put(DBInfo.version, value);
  });

  Get.find<SyncController>().timetableSyncStatus.value = false;
  Get.find<SyncController>().clickable.value = true;
  Get.find<SyncController>().lastUpdate.value = lastUpdate;

  Get.find<HomeController>().newUpdate.value = false;

  GetXUtilities.snackbar(
      title: 'Synced!',
      message: 'Data Synchronized Successfully!',
      gradient: successGradient);

  // Get.delete<StudentTimetableController>();
  // Get.delete<TeacherTimetableController>();
}
