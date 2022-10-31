// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cui_timetable/app/constants/notification_constants.dart';
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/light_theme.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  late final Box box;

  var searchBy = <String, bool>{"list": false, "section": true}.obs;

  final darkMode = true.obs;
  final carousel = true.obs;
  final latestNews = true.obs;

  final cloudNotiStateTrue = true.obs;
  final cloudNotiStateFalse = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    box = await Hive.openBox(DBNames.settings);
    _gettingValues();
  }

  Future<void> _gettingValues() async {
    // box.delete(DBSettings.searchBy);
    searchBy.value = Map<String, bool>.from(await box.get(DBSettings.searchBy,
        // ignore: invalid_use_of_protected_member
        defaultValue: searchBy.value));

    // setting cloud messaging state
    cloudNotiStateTrue.value =
        box.get(DBSettings.cloudNoti, defaultValue: true);
    if (cloudNotiStateTrue.value) {
      FirebaseMessaging.instance.subscribeToTopic(notificationsForAll);
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(notificationsForAll);
    }
    cloudNotiStateFalse.value = !cloudNotiStateTrue.value;

    darkMode.value = box.get(DBSettings.darkMode, defaultValue: false);

    carousel.value = box.get(DBSettings.carousel, defaultValue: true);
    latestNews.value = box.get(DBSettings.latestNews, defaultValue: true);
  }

  Future<void> setSearchBy() async {
    searchBy.forEach((key, value) {
      searchBy[key] = !searchBy[key]!;
    });
    await box.put(DBSettings.searchBy, searchBy);

    // print(box.get(DBSettings.searchBy));
  }

  resetCloudNotiState() async {
    cloudNotiStateTrue.value = !cloudNotiStateTrue.value;
    cloudNotiStateFalse.value = !cloudNotiStateFalse.value;

    if (cloudNotiStateTrue.value) {
      FirebaseMessaging.instance.subscribeToTopic(notificationsForAll);
      await box.put(DBSettings.cloudNoti, true);
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(notificationsForAll);
      await box.put(DBSettings.cloudNoti, false);
    }
  }

  void setDarkMode(value) {
    if (value) {
      box.put(DBSettings.darkMode, true);

      Get.changeTheme(ThemeData.dark());
      // Get.find<HomeController>().notifier.value = ThemeMode.dark;
    } else {
      box.put(DBSettings.darkMode, false);

      Get.changeTheme(lightTheme(isLarge: Get.find<HomeController>().isLarge));
    }
    darkMode.value = value;

    // changing theme
  }

  void setCarousel(value) {
    if (value) {
      box.put(DBSettings.carousel, true);
    } else {
      box.put(DBSettings.carousel, false);
    }
    carousel.value = value;
  }

  void setLatestNews(value) {
    if (value) {
      box.put(DBSettings.latestNews, true);
    } else {
      box.put(DBSettings.latestNews, false);
    }
    latestNews.value = value;
  }

  Future<void> clearCache() async {
    final timetableCache = await Hive.openBox(DBNames.timetableCache);
    final remainderCache = await Hive.openBox(DBNames.remainderCache);
    // final remainder = await Hive.openBox(DBNames.remainder);
    await timetableCache.clear();
    await remainderCache.clear();
    // await remainder.clear();
    GetXUtilities.snackbar(
        title: 'Cache removed!',
        message: "Your app is now reset.",
        gradient: successGradient);
  }
}
