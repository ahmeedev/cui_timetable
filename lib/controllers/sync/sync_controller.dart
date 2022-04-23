import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:cui_timetable/controllers/database/database_controller.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SyncController extends GetxController {
  var data = [].obs;
  var stillSync = false.obs;

  syncData() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    await remoteConfig.setDefaults(const {
      "version": 0,
    });

    await remoteConfig.fetchAndActivate();

    final remoteVersion = remoteConfig.getInt('version');
    final box = await Hive.openBox('info');

    if (box.get('version') != remoteVersion) {
      stillSync.value = true;
      await _downloadFile(remoteVersion);
    } else {
      Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Sync',
          backgroundColor: Colors.green,
          messageText: const Text('Data is already Syncrhonzied')));
    }
  }

  Future<void> _downloadFile(remoteVersion) async {
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
              await controller.deleteData().then((value) async => {
                    await controller
                        .insertData(data, remoteVersion)
                        .then((value) => Hive.close())
                  });

              stillSync.value = false;
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
