import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/timetable_database.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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
    final timetableDB = TimetableDatabase();
    await timetableDB.createDatabase();

    return Future.value(true);
  }

  Future<void> _insertTime() async {
    final box = await Hive.openBox(DBNames.timeSlots);

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
