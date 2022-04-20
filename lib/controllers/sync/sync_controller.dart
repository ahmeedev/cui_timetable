import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:cui_timetable/controllers/database/database_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

import 'package:path_provider/path_provider.dart';

class SyncController extends GetxController {
  var data = [].obs;
  var stillSync = false.obs;
  // late final bool updated;

  // @override
  // Future<void> onInit() async {
  //   // final box = await Hive.openBox('info');
  //   try {
  //     // updated = box.get('updated');
  //   } catch (e) {
  //     // updated = false;
  //   }
  //   super.onInit();
  // }

  syncData() async {
    stillSync.value = true;
    await _downloadFile();
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
          inner() async {
            final Directory directory =
                await getApplicationDocumentsDirectory();

            await compute(_getDownloadedContent, directory.path)
                .then((data) async {
              final controller = Get.find<DatabaseController>();
              await controller.insertData(data).then((value) => Hive.close());
              stillSync.value = false;
              Hive.close();
              print('totally completed');
            });
          }
          inner();
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

Future<List<dynamic>> _getDownloadedContent(String location) async {
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
    // Isolate.exit(port, map);
  }
  return Future<List<dynamic>>.value(fields);
}

/// Update the timetable in firebase.
Future<void> updateLectures(List<dynamic> data) async {
  // // Fetching sections from the list.
  // final sections = <String>{};
  // for (var item in data) {
  //   sections.add(item[0]);
  // }
  // print(sections);

  // final box = await Hive.openBox("info");
  // box.put("sections", sections.toList());

  // int counter = 0;
  // for (var i in sections) {
  //   final storage = await Hive.openBox('$i');
  //   print('$i created ${counter}');
  //   counter++;
  // }

  // counter = 0;
  // for (var i in data) {
  //   // final storage = Hive.box(i[0].toString());
  //   storage.put('lec$counter', [
  //     i[1].toString(),
  //     i[2].toString(),
  //     i[3].toString(),
  //     i[4].toString(),
  //     i[5].toString()
  //   ]);
  //   print(i);
  //   counter++;
  // }

  // Hive.close();
  devlog.log('Data inserted Successfully...', name: "HIVE[SYNC]");
}

/// Setting last data and sync button off.
// Future<bool> _updateStatus() async {
//   final box = await Hive.openBox("info");
//   box.put("last_update", Jiffy().yMMMMd.toString());
//   box.put('updated', true);
//   box.close();
//   devlog.log('Values Updated', name: 'SYNC');
//   return Future<bool>.value(true);
// }
