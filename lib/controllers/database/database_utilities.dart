import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:cui_timetable/views/utilities/loc_utilities.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

Future<void> downloadFile({required String fileName, required callback}) async {
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
        });
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
    print(e);
    devlog.log("Error!, While file Reading... ", name: "SYNC_READ");
  } finally {
    // Isolate.exit(port, map);

  }
  return Future<List<dynamic>>.value(fields);
}






  // insertTimetable(controller, remoteVersion, dialogPop) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   await compute(_getDownloadedContent, directory.path).then((data) async {
  //     await controller.insertDataOfTimetable(data, remoteVersion);

  //     if (dialogPop) {
  //       final box = await Hive.openBox('info');
  //       box.put('new_user', false);
  //       Get.back();
  //     }
  //     stillSync.value = false;
  //     final box = await Hive.openBox('info');
  //     lastUpdate.value = box.get('last_update');

  //     GetXUtilities.snackbar(
  //         title: 'Sync',
  //         message: 'Data Synchronized Successfully',
  //         gradient: successGradient);
  //   });
  // }
