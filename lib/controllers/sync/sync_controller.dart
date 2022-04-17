import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class SyncController extends GetxController {
  final logger = Logger();

  var data = [].obs;
  var stillSync = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

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
          Hive.close();
          test() async {
            final status = await _createDatabase().then((value) async {
              if (value) {
                stillSync.value = false;
                print('execute');
              }
            }); // for loading status
            // stillSync.value = false;
          }
          test();
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
  final fields =
      await compute(_getDownloadedContent, directory.path).then((value) async {
    if (value) {
      await _updateStatus();
    }
  });

  print('end of execution');
  return Future.value(true);
  // print(fields);
}

Future<bool> _getDownloadedContent(String location) async {
  var fields;
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
    await _creatingDatabase(fields, location);
    // Isolate.exit(port, map);
  }
  return Future<bool>.value(true);
}

Future<bool> _creatingDatabase(result, String location) async {
  Hive.init(location);
  // Deleting the existing database
  await _truncateDatabase();

  devlog.log("New Database Created", name: "HIVE[SYNC]");
  return Future<bool>.value(true);
}

Future<bool> _truncateDatabase() async {
  // final box = await Hive.openBox("info");
  // print(sections.get('sections'));
  // final sections = box.get("sections");
  // for (var i in sections) {
  //   Hive.deleteBoxFromDisk(i);
  // }
  // Hive.deleteBoxFromDisk("info")
  // Hive.deleteFromDisk();
  Hive.openBox("info");
  Hive.deleteFromDisk();
  devlog.log("Database Truncated", name: "HIVE[SYNC]");
  return Future<bool>.value(true);
}

/// Setting last data and sync button off.
Future<bool> _updateStatus() async {
  final box = await Hive.openBox("info");
  box.put("last_update", Jiffy().yMMMMd.toString());
  box.put('test', 'na ker');
  Hive.close();
  devlog.log('Values Updated', name: 'SYNC');
  return Future<bool>.value(true);
}
