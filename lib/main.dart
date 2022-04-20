import 'dart:developer' as devlog;

import 'package:cui_timetable/controllers/csv/csv_controller.dart';
import 'package:cui_timetable/controllers/database/database_controller.dart';
import 'package:cui_timetable/controllers/developer/developer_controller.dart';
import 'package:cui_timetable/controllers/firebase/firebase_controller.dart';
import 'package:cui_timetable/controllers/freerooms/freerooms_controller.dart';
import 'package:cui_timetable/controllers/home/home_controller.dart';
import 'package:cui_timetable/firebase_options.dart';
import 'package:cui_timetable/style.dart';
import 'package:cui_timetable/views/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  await _initialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

Future<void> _initialized() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  devlog.log("Firebase Initialized...", name: 'FIREBASE');

  final loc = await getApplicationDocumentsDirectory();
  Hive.init(loc.path.toString());
  devlog.log("Hive Initialized...", name: 'HIVE');

  // Initialize the important Controllers
  //* ============================================ //
  Get.put(FirebaseController()); //! Criticial to load first
  Get.put(DatabaseController()); // ! 2
  Get.put(HomeController());
  Get.put(FreeRoomsController());
  // final startUpController = Get.put(StartUpController()); // *2
  // Get.put(StartUpController()); // *2
  Get.put(DeveloperController()); // *3
  // Get.put(CsvController());
  //* ============================================ //

  // print(DateFormat.yMMMd]().format(DateTime.now()));
}

/// Root Widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: lightTheme(),
        title: 'CUI TIMETABLE',
        debugShowCheckedModeBanner: false,
        home: SafeArea(top: false, child: Home()));
  }
}
