import 'dart:developer' as devlog;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/light_theme.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';
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
    name: 'cui-timetable',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance;
  await db.collection("info").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });

  devlog.log("Firebase Initialized...", name: 'FIREBASE');

  Hive.init(LocationUtilities.defaultpath);
  devlog.log("Hive Initialized...", name: 'HIVE');
}

/// Root Widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme(context),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      title: 'CUI TIMETABLE',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
