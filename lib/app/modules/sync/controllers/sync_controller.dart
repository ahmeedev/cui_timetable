import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cui_timetable/app/data/database/freerooms/freerooms_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/timeslots/timeslots_database.dart';
import 'package:cui_timetable/app/data/database/timetable/timetable_database.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';

// Package imports:

// Project imports:

class SyncController extends GetxController {
  var clickable = true.obs;
  var lastUpdate = ''.obs;
  var timetableSyncStatus = false.obs;
  var freeroomsSyncStatus = false.obs;
  // ignore: prefer_typing_uninitialized_variables

  @override
  Future<void> onInit() async {
    final box = await Hive.openBox(DBNames.info);
    lastUpdate.value = box.get(DBInfo.lastUpdate) ?? 'No Record';

    super.onInit();
  }

  syncData({dialogPop = false}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final box = await Hive.openBox(DBNames.info);
      await getRemoteVersion().then((remoteVersion) async {
        if (box.get(DBInfo.version).toString() != remoteVersion) {
          // insert time in main isolate
          if (dialogPop) {
            GetXUtilities.dialog();
          } else {
            clickable.value = false;
            // update the sync statuses.
            timetableSyncStatus.value = true;
          }
          // await _insertTime();
          await _syncAllFiles();
        } else {
          // Execute when the user is new and already synchronized
          if (dialogPop) {
            Get.back();
          }
          GetXUtilities.snackbar(
              title: 'Synced!',
              message: 'Data Already Synchronized..',
              gradient: successGradient);
        }
      });
    } else {
      GetXUtilities.snackbar(
          title: 'Error!!',
          message: 'Make sure you have a internet connection',
          gradient: errorGradient);
    }
  }

  Future<bool> _syncAllFiles() async {
    final timeslots = TimeslotsDatabase();
    await timeslots.createDatabase();
    final timetableDB = TimetableDatabase();
    await timetableDB.createDatabase();

    // final freerooms = FreeRoomsDatabase();
    // await freerooms.createDatabase();

    return Future.value(true);
  }
}

/// .
/// [FUNCTION]

Future<String> getRemoteVersion() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(minutes: 1),
  ));

  await remoteConfig.setDefaults(const {
    "version": 0,
  });

  await remoteConfig.fetchAndActivate();

  final remoteVersion = remoteConfig.getInt('version').toString();
  return Future.value(remoteVersion);
}
