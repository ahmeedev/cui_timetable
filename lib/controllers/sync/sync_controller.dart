import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class SyncController extends GetxController {
  final logger = Logger();

  var data = [].obs;
  var stillSync = false.obs;

  syncData() async {
    stillSync.value = true;
    await _downloadFile();
    print(Jiffy().yMMMMEEEEdjm);
  }

  _downloadFile() async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    final islandRef = storageRef.child("timetable.csv");

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.path}/timetable.csv";
    final file = File(filePath);

    final downloadTask = islandRef.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          devlog.log("Start Downloading...", name: "SYNC_DOWN");
          break;
        case TaskState.paused:
          devlog.log("File Downloading Paused Unexpectedly...",
              name: "SYNC_DOWN");
          break;
        case TaskState.success:
          final status = _createDatabase();
          status.then((value) => stillSync.value = false); // for loading status
          // _getDownloadedContent(port);
          devlog.log("File Downloaded Successfully...", name: "SYNC_DOWN");
          break;
        case TaskState.canceled:
          devlog.log("File Downloading Cancelled...", name: "SYNC_DOWN");
          break;
        case TaskState.error:
          devlog.log("Error Occured While Downloading", name: "SYNC_DOWN");
          break;
      }
    });
  }
}

/// For compute
Future<bool> _createDatabase() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final fields = await compute(_getDownloadedContent, directory.path);
  print('end of execution');
  return Future.value(false);
  // print(fields);
}

Future<dynamic> _getDownloadedContent(String location) async {
  var fields;
  var result;
  try {
    final File file = File('$location/timetable.csv');
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
    result = Future<dynamic>.value(fields);
    // Isolate.exit(port, map);
  }
  return result;
}
