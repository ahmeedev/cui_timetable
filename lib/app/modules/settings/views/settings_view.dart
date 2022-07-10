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
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding * 2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Preferences",
              //   style: Theme.of(context)
              //       .textTheme
              //       .labelLarge!
              //       .copyWith(color: Colors.black),
              // ),
              // kHeight,
              // _buildSettingTile(
              //     label: "Dark Mode",
              //     value: controller.darkMode,
              //     callback: controller.setDarkMode),
              // kHeight,
              // kHeight,
              Text(
                "General",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),
              kHeight,
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  title: Obx(() => Row(
                        children: [
                          const Text("Search By"),
                          const Spacer(),
                          buildButtonList(
                            title: '   List   ',
                            obs: controller.searchBy["list"],
                          ),
                          buildButtonList(
                              title: 'Section',
                              obs: controller.searchBy["section"],
                              last: true),
                          // kWidth,
                          // Container(
                          //     decoration: BoxDecoration(
                          //         color: textFieldColor,
                          //         borderRadius: BorderRadius.only(
                          //           topRight:
                          //               Radius.circular(Constants.defaultRadius),
                          //           bottomRight:
                          //               Radius.circular(Constants.defaultRadius),
                          //         )),
                          //     child: Padding(
                          //       padding:
                          //           EdgeInsets.all(Constants.defaultPadding - 2),
                          //       child: const Text('Section'),
                          //     )),
                        ],
                      )),
                ),
              ),
              // _buildSettingTile(
              //     label: "Search By",
              //     value: controller.darkMode,
              //     callback: controller.setDarkMode),
              kHeight,
              kHeight,
              Text(
                "Home",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),
              kHeight,
              _buildSettingTile(
                  label: "Show Carousel",
                  value: controller.carousel,
                  callback: controller.setCarousel),
              kHeight,
              _buildSettingTile(
                  label: "Show News",
                  value: controller.latestNews,
                  callback: controller.setLatestNews),
            ]),
      ),
    );
  }

  InkWell buildButtonList({required String title, required obs, last = false}) {
    return InkWell(
      onTap: () => controller.setSearchBy(),
      child: Container(
          decoration: BoxDecoration(
              color: obs == true ? primaryColor : textFieldColor,
              borderRadius: last == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(Constants.defaultRadius),
                      bottomRight: Radius.circular(Constants.defaultRadius),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(Constants.defaultRadius),
                      bottomLeft: Radius.circular(Constants.defaultRadius),
                    )),
          child: Padding(
            padding: EdgeInsets.all(Constants.defaultPadding - 2),
            child: Text(title),
          )),
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
