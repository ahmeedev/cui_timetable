import 'dart:convert';
import 'dart:developer' as devlog;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:csv/csv.dart';
import 'package:cui_timetable/controllers/database/timetable_database_controller.dart';
import 'package:cui_timetable/style.dart';
import 'package:cui_timetable/views/timetable/timetable_main.dart';
import 'package:cui_timetable/views/utilities/get_utilities.dart';
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
      _insertTime();

      // commit this for the without condition synchronization.
      // await _downloadFile(
      //     remoteVersion);

      // if (box.get('version') != remoteVersion) {
      //   stillSync.value = true;
      //   if (dialogPop) {
      //     await _downloadFile(remoteVersion, dialogPop: true);
      //   } else {
      //     // await _downloadFile(remoteVersion);
      //   }
      // } else {
      //   // Execute when the user is new and already synchronized
      //   if (dialogPop) {
      //     Get.back();
      //   }
      //   GetXUtilities.snackbar(
      //       title: 'Sync',
      //       message: 'Data is Already Synchronized',
      //       gradient: successGradient);
      // }
    } else {
      GetXUtilities.snackbar(
          title: 'Sync',
          message: 'Make sure you have a connection',
          gradient: errorGradient);
    }
  }

  Future<void> _insertTime() async {
    final box = await Hive.openBox('timeSlots');

    var collection = FirebaseFirestore.instance.collection('info');
    var docSnapshot = await collection.doc('time').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      final time1 = data?['monToThur'];
      final time2 = data?['fri'];
      box.put('monToThur', time1);
      box.put('fri', time2);
    } else {
      final time = {
        "1": "08:30AM - 10:00AM",
        "2": "10:00AM - 11:30AM",
        "3": "11:30AM - 01:00PM",
        "4": "01:30PM - 03:00PM",
        "5": "03:00PM - 04:30PM",
      };
      box.put('defaultTime', time);
    }

    print(box.get('monToThur'));
    print(box.get('fri'));
  }

  Future<String> getRemoteVersion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    await remoteConfig.setDefaults(const {
      "version": 0,
    });

    await remoteConfig.fetchAndActivate();

    final remoteVersion = remoteConfig.getInt('version').toString();
    return Future.value(remoteVersion);
  }

  // insertTimetable(controller, remoteVersion, dialogPop) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   await compute(_getDownloadedContent, directory.path).then((data) async {
  //     await controller.insertTimetableData(data, remoteVersion);

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
}
