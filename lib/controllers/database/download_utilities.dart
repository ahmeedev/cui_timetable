import 'dart:developer' as devlog;
import 'dart:io';

import 'package:cui_timetable/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

downloadFile(map) async {
  await Firebase.initializeApp();

  // Create a storage reference from our app

  final storageRef = FirebaseStorage.instance.ref();
  final islandRef = storageRef.child(map['remoteFileName']);
  final filePath = "${map['defaultLocalLocation']}/${map['remoteFileName']}";
  final file = File(filePath);

  final downloadTask = islandRef.writeToFile(file);
  downloadTask.snapshotEvents.listen((taskSnapshot) async {
    switch (taskSnapshot.state) {
      case TaskState.running:
        devlog.log("Start Downloading...",
            name: map['remoteFileName'].toUpperCase());
        break;
      case TaskState.paused:
        devlog.log("File Downloading Paused Unexpectedly...",
            name: map['remoteFileName'].toUpperCase());
        break;
      case TaskState.success:
        // final controller = Get.find<TimetableDatabaseController>();
        // await controller.deleteData();

        // insertTimetable(controller, remoteVersion, dialogPop);

        devlog.log("File Downloaded Successfully...",
            name: map['remoteFileName'].toUpperCase());
        break;
      case TaskState.canceled:
        devlog.log("File Downloading Cancelled...",
            name: map['remoteFileName'].toUpperCase());
        break;
      case TaskState.error:
        devlog.log("File Downloading Cancelled...",
            name: map['remoteFileName'].toUpperCase());
        break;
    }
  });
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