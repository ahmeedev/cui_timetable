import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:csv/csv.dart';
import 'package:cui_timetable/controllers/database/timetable_database_controller.dart';
import 'package:cui_timetable/models/utilities/get_utilities.dart';
import 'package:cui_timetable/style.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SyncController extends GetxController {
  var data = [].obs;
  var lastUpdate = ''.obs;
  var stillSync = false.obs;

  @override
  Future<void> onInit() async {
    final box = await Hive.openBox('info');
    try {
      lastUpdate.value = box.get('last_update');
      print(lastUpdate.value);
    } catch (e) {
      print(e);
    }
    super.onInit();
  }

  syncData({dialogPop = false}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
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

      // commit this for the without condition synchronization.
      // await _downloadFile(
      //     remoteVersion);

      if (box.get('version') != remoteVersion) {
        stillSync.value = true;
        if (dialogPop) {
          await _downloadFile(remoteVersion, dialogPop: true);
        } else {
          await _downloadFile(remoteVersion);
        }
      } else {
        // Execute when the user is new and already synchronized
        if (dialogPop) {
          Get.back();
        }
        GetXUtilities.snackbar(
            title: 'Sync',
            message: 'Data is Already Synchronized',
            gradient: successGradient);
      }
    } else {
      print('check your internet');
      GetXUtilities.snackbar(
          title: 'Sync',
          message: 'Make sure you have a connection',
          gradient: errorGradient);
    }
  }

  Future<void> _downloadFile(remoteVersion, {dialogPop = false}) async {
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
              final controller = Get.find<TimetableDatabaseController>();
              await controller.deleteData().then((value) async => {
                    await controller
                        .insertData(data, remoteVersion)
                        .then((value) => Hive.close())
                  });

              if (dialogPop) {
                final box = await Hive.openBox('info');
                box.put('new_user', false);
                Get.back();
              }
              stillSync.value = false;
              final box = await Hive.openBox('info');
              lastUpdate.value = box.get('last_update');

              GetXUtilities.snackbar(
                  title: 'Sync',
                  message: 'Data Synchronized Successfully',
                  gradient: successGradient);
            });
          }
          inner();
          devlog.log("File Downloaded Successfully...", name: "SYNC_DOWN");
          break;
        case TaskState.canceled:
          devlog.log("File Downloading Cancelled...", name: "SYNC_DOWN");
          break;
        case TaskState.error:
          GetXUtilities.snackbar(
              title: 'Sync',
              message: 'Make Sure You Have a Internet Connection',
              gradient: errorGradient);
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
