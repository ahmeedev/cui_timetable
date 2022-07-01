// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  late final box;
  final darkMode = true.obs;
  final carousel = true.obs;
  final latestNews = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    box = await Hive.openBox(DBNames.settings);
    _gettingValues();
  }

  void _gettingValues() {
    darkMode.value = box.get(DBSettings.darkMode, defaultValue: true);

    carousel.value = box.get(DBSettings.carousel, defaultValue: true);
    latestNews.value = box.get(DBSettings.latestNews, defaultValue: true);
  }

  void setDarkMode(value) {
    if (value) {
      box.put(DBSettings.darkMode, true);
      Get.changeTheme(ThemeData.dark());
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

  @override
  void onClose() {
    super.onClose();
    box.close();
  }
}