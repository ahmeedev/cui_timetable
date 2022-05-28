import 'dart:convert';
import 'dart:developer' as devlog;

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/timeslots/timeslots_database.dart';
import 'package:cui_timetable/app/data/models/timetable_model.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/theme/light_theme_for_large_screens.dart';
import 'package:cui_timetable/app/theme/light_theme_for_small_screens.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';
import 'package:cui_timetable/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await _initialized();
  final box = await Hive.openBox(DBNames.freerooms);
  print(box.get(DBFreerooms.friday));
  runApp(const MyApp());
}

Future<void> _initialized() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await LocationUtilities.initialize();

  await Firebase.initializeApp(
    name: 'cui-timetable',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  devlog.log("Firebase Initialized...", name: 'FIREBASE');

  Hive.init(LocationUtilities.defaultpath);
  devlog.log("Hive Initialized...", name: 'HIVE');
}

/// Root Widget of the application.
class MyApp extends GetView<HomeController> {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Constants.initializeFields(
            elevation: 10.0,
            padding: 10.0,
            radius: 10.0,
            icon: 26.0,
            overlaySize: 5,
            flex: 6,
            IWidth: 100.0,
            IHeight: 100.0);
        if (constraints.maxWidth < 380) {
          return getMaterialApp(theme: lightThemeForSmallScreens(context));
        } else {
          // Constants.initializeFields(
          //     elevation: 10.0, padding: 10.0, radius: 10.0, icon: 20.0);
          return getMaterialApp(theme: lightThemeForLargeScreens(context));
        }
      },
    );
  }

  getMaterialApp({required theme}) {
    return GetMaterialApp(
      theme: theme,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      title: 'CUI TIMETABLE',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
