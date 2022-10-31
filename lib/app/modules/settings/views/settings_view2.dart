import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/global_widgets.dart';
import '../controllers/settings_controller.dart';

class SettingsView2 extends GetView<SettingsController> {
  const SettingsView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          kHeight,
          _buildTag(context: context, text: 'General'),
          kHeight,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
                title: Obx(() => Row(
                      children: [
                        const Text("Search By"),
                        const Spacer(),
                        buildButtonList(
                          context: context,
                          title: '   List   ',
                          obs: controller.searchBy["list"],
                          onTap: controller.setSearchBy,
                        ),
                        buildButtonList(
                            onTap: controller.setSearchBy,
                            context: context,
                            title: 'Section',
                            obs: controller.searchBy["section"],
                            last: true),
                      ],
                    ))),
          ).paddingSymmetric(horizontal: Constants.defaultPadding),
          kHeight,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
                title: Obx(() => Row(
                      children: [
                        const Text("Cloud Notifications"),
                        const Spacer(),
                        buildButtonList(
                            context: context,
                            title: '   Off   ',
                            obs: controller.cloudNotiStateFalse,
                            onTap: controller.resetCloudNotiState),
                        buildButtonList(
                            context: context,
                            title: '   On   ',
                            obs: controller.cloudNotiStateTrue,
                            onTap: controller.resetCloudNotiState,
                            last: true),
                      ],
                    ))),
          ).paddingSymmetric(horizontal: Constants.defaultPadding),

          // kHeight,
          // _buildSettingTile(
          //     label: "Show Carousel",
          //     value: controller.carousel,
          //     callback: controller.setCarousel),
          // kHeight,
          // _buildSettingTile(
          //     label: "Show News",
          //     value: controller.latestNews,
          //     callback: controller.setLatestNews),
          kHeight,
          kHeight,
          _buildTag(context: context, text: "Miscellaneous"),
          kHeight,
          Card(
            child: ListTile(
              title: const Text('Clear cache'),
              trailing: ElevatedButton(
                  onPressed: () {
                    controller.clearCache();
                  },
                  child: const Text("Clear")),
            ),
          ).paddingSymmetric(horizontal: Constants.defaultPadding)
        ]);
  }

  _buildTag({required context, required text}) {
    final theme = Theme.of(context);

    return Card(
        color: primaryColor.withOpacity(0.8),
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Constants.defaultRadius / 2),
                bottomRight: Radius.circular(Constants.defaultRadius / 2))),
        margin: EdgeInsets.zero,
        child: Text(
          text,
          style: theme.textTheme.titleSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ).paddingAll(Constants.defaultPadding)
        // .paddingSymmetric(horizontal: Constants.defaultPadding),
        );
    // .paddingSymmetric(horizontal: Constants.defaultPadding);
  }

  InkWell buildButtonList({
    required context,
    required String title,
    required obs,
    required onTap,
    last = false,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
          decoration: BoxDecoration(
              color: obs == true ? primaryColor : selectionColor,
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
            padding: EdgeInsets.all(obs == true
                ? Constants.defaultPadding
                : Constants.defaultPadding - 1),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: obs == true ? Colors.white : Colors.black),
            ),
          )),
    );
  }
}
