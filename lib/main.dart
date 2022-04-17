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

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  await _initialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

Future<void> _initialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  devlog.log("Firebase Initialized...", name: 'FIREBASE');
  // final loc = await getApplicationDocumentsDirectory();
  // Hive.init(loc.path.toString());
  Hive.initFlutter();
  devlog.log("Hive Initialized...", name: 'HIVE');

  // Initialize the important Controllers
  //* ============================================ //
  Get.put(FirebaseController()); //! Criticial to load first
  // final startUpController = Get.put(StartUpController()); // *2
  // Get.put(StartUpController()); // *2
  Get.put(DeveloperController()); // *3
  Get.put(CsvController());
  Get.put(DatabaseController());
  Get.put(FreeRoomsController());
  Get.put(HomeController());
  //* ============================================ //

  // startUpController.fetchSections();
  // print(DateFormat.yMMMd]().format(DateTime.now()));
}

/// Root Widget of the application.
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // devlog.log('Sections fected...', name: 'HIVE');
    return GetMaterialApp(
        // showSemanticsDebugger: true,
        // showPerformanceOverlay: true,
        theme: lightTheme(),
        title: 'CUI TIMETABLE',
        debugShowCheckedModeBanner: false,
        home: SafeArea(top: false, child: Home()));
  }
}
