import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  late final box;
  final carousel = true.obs;

  @override
  void onInit() {
    super.onInit();
    box = Hive.openBox(DBNames.settings);
    _gettingValues();
  }

  void setCarousel(value) {
    box = carousel.value = value;
  }

  void _gettingValues() {
    carousel.value = box.get(DBSettings.carousel, defaultValue: false);
  }
}
