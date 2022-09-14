import 'dart:developer' as devlog;
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cui_timetable/app/constants/notification_constants.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

import 'app/data/models/timetable/student_timetable/student_timetable.dart';
import 'app/data/models/timetable/teacher_timetable/teacher_timetable.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/home/views/home_view2.dart';
import 'app/modules/news/controllers/news_controller.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/modules/sync/controllers/sync_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_constants.dart';
import 'app/theme/light_theme.dart';
import 'app/utilities/location/loc_utilities.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  await _initialized();

  runApp(MyApp());
}

Future<void> _initialized() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await LocationUtilities.initialize();
  await initlializeHiveAdapters();
  await Firebase.initializeApp(
    name: 'cui-timetable',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeLocalNotifications();
  devlog.log("Firebase Initialized...", name: 'FIREBASE');

  Hive.init(LocationUtilities.defaultpath);
  devlog.log("Hive Initialized...", name: 'HIVE');

  // Initialize important controllers //
  Get.put<HomeController>(
    HomeController(),
  );
  Get.put<SettingsController>(
    SettingsController(),
  );

  Get.put<SyncController>(
    SyncController(),
  );

  Get.lazyPut<NewsController>(
    () => NewsController(),
  );
}

initlializeHiveAdapters() {
  Hive.registerAdapter(StudentTimetableAdapter());
  Hive.registerAdapter(TeacherTimetableAdapter());
}

initializeLocalNotifications() {
  AwesomeNotifications().initialize(
      // 'resource://drawable/res_app_icon',
      null,
      [
        NotificationChannel(
            channelKey: channelRemainderKey,
            channelName: channelRemainder,
            channelDescription: channelRemainderDescription,
            defaultColor: primaryColor,
            ledColor: Colors.red)
      ],
      debug: true);

  AwesomeNotifications().createdStream.listen((event) {
    print(event.toMap().toString());
  });
}

/// Root Widget of the application.
class MyApp extends GetView<HomeController> {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 380) {
          Constants.initializeFields(
              elevation: 10.0,
              padding: 8.0,
              radius: 10.0,
              icon: 20.0,
              overlaySize: 4.6,
              flex: 5,
              IWidth: 80.0,
              IHeight: 80.0);
          controller.isLarge = false;
          return getMaterialApp(
              theme: lightTheme(isLarge: false), context: context);
        } else {
          Constants.initializeFields(
              elevation: 10.0,
              padding: 10.0,
              radius: 10.0,
              icon: 26.0,
              overlaySize: Platform.isIOS ? 4.2 : 4.6, //! critical
              flex: 6,
              IWidth: 100.0,
              IHeight: 100.0);
          controller.isLarge = true;

          return getMaterialApp(
              theme:
                  // Get.find<SettingsController>().darkMode.value
                  //     ? ThemeData.dark()
                  //     :
                  lightTheme(isLarge: true),
              context: context);
        }
      },
    );
  }

  getMaterialApp({required theme, required context}) {
    return GetMaterialApp(
      theme: theme,
      // darkTheme: ThemeData.dark(),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      title: 'CUI TIMETABLE',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      // home: HomeView2(),
    );
  }
}
