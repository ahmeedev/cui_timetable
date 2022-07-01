import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding * 2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preferences",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),
              kHeight,
              _buildSettingTile(
                  label: "Show Carousel",
                  value: controller.carousel,
                  callback: controller.setCarousel)
            ]),
      ),
    );
  }

  _buildSettingTile(
      {required String label, required Rx<bool> value, required callback}) {
    return Obx(() => Card(
        margin: EdgeInsets.zero,
        child: SwitchListTile(
            activeColor: primaryColor,
            title: Text(label),
            value: value.value,
            onChanged: callback)));
  }
}
