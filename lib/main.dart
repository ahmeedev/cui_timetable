import 'dart:developer' as devlog;

import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/light_theme.dart';
import 'package:cui_timetable/app/utilities/loc_utilities.dart';
import 'package:cui_timetable/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  await _initialized();

  runApp(const MyApp());
}

Future<void> _initialized() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocationUtilities.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  devlog.log("Firebase Initialized...", name: 'FIREBASE');

  Hive.init(LocationUtilities.defaultpath);
  devlog.log("Hive Initialized...", name: 'HIVE');

  // Initialize the important Controllers
  //* ============================================ //
  // Get.put(FirebaseController()); //! Criticial to load first
  // // Get.put(TimetableDatabaseController()); // ! 2
  // Get.put(HomeController());
  // Get.put(FreeRoomsController());
  // Get.put(SyncController());

  // Get.put(DeveloperController()); // *3
  //* ============================================ //
}

/// Root Widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme(context),
      defaultTransition: Transition.cupertino,
      title: 'CUI TIMETABLE',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // debugShowCheckedModeBanner: false,
      // home: SafeArea(top: false, child: HomeView())
    );
  }
}
