import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

Future<void> downloadFile({
  required String fileName,
  required callback,
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
        devlog.log("File Downloaded Successfully...",
            name: fileName.toUpperCase());
        compute(_backgroundTask, {
          "filePath": LocationUtilities.defaultpath,
          "fileName": fileName,
          "callback": callback
        }).then((value) => _updateStatuses());
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

_backgroundTask(map) async {
  await _getFileContent(
          fileLocation: map["filePath"], fileName: map["fileName"])
      .then((data) => map["callback"](filePath: map['filePath'], data: data));
}

Future<List<dynamic>> _getFileContent(
    {required String fileLocation, required String fileName}) async {
  var fields;
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

_updateStatuses() async {
  final box1 = await Hive.openBox(DBNames.info);
  bool newUser = box1.get(DBInfo.newUser, defaultValue: true);
  if (newUser) {
    box1.put(DBInfo.newUser, false);
    Get.back();
  }

  box1.put(DBInfo.lastUpdate, Jiffy().format("MMMM do yyyy"));

  await getRemoteVersion().then((value) {
    box1.put(DBInfo.version, value);
  });

  Get.find<SyncController>().timetableSyncStatus.value = false;
  Get.find<SyncController>().clickable = true;

  // Get.delete<StudentTimetableController>();
  // Get.delete<TeacherTimetableController>();
}
