import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';
import '../../../data/database/database_utilities_methods.dart';
import '../../../data/database/datesheet_db/datesheet_database.dart';
import '../../../data/database/freerooms_db/freerooms_database.dart';
import '../../../data/database/timeslots_db/timeslots_database.dart';
import '../../../data/database/timetable_db/timetable_database.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/get_widgets.dart';

class SyncController extends GetxController {
  var syncFile = 0.obs; //! crontroll the sync action of multiple files
  var clickable = true.obs;
  var lastUpdate = ''.obs;

  var timetableSyncStatus = false.obs;
  var datesheetSyncStatus = false.obs;
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
            // timetableSyncStatus.value = true;
            // freeroomsSyncStatus.value = true;
          }
          // await _insertTime();
          await syncAllFiles();
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

  Future<bool> syncAllFiles() async {
    await closeDatabases();

    final timeslots = TimeslotsDatabase();
    await timeslots.createDatabase();

    ever(syncFile, (_) async {
      if (_ == 1) {
        await Future.delayed(const Duration(milliseconds: 200));
        final timetableDB = TimetableDatabase();
        timetableSyncStatus.value = true;
        await timetableDB.createDatabase();
      } else if (_ == 2) {
        await Future.delayed(const Duration(milliseconds: 200));
        final datesheetDB = DatesheetDatabase();
        datesheetSyncStatus.value = true;
        await datesheetDB.createDatabase();
      } else if (_ == 3) {
        await Future.delayed(const Duration(milliseconds: 200));
        final freerooms = FreeRoomsDatabase();
        freeroomsSyncStatus.value = true;
        await freerooms.createDatabase(lastEntity: true);
      }
    });

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
