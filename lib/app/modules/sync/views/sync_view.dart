// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/sync_controller.dart';

class SyncView extends GetView<SyncController> {
  const SyncView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync'),
        centerTitle: true,
      ),
      body: const SyncBody(),
    );
  }
}

class SyncBody extends GetView<SyncController> {
  const SyncBody({Key? key}) : super(key: key);

  // final lastUpdate = '15-apr-2022';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.defaultPadding * 1.5),
      child: Column(
        children: [
          Obx(() => SyncTile(
                title: 'Timetable',
                lastUpdate: controller.lastUpdate.value,
                icon: controller.timetableSyncStatus.value
                    ? const SpinKitChasingDots(
                        color: primaryColor,
                        size: 30.0,
                      )
                    : Get.find<HomeController>().newUpdate.value
                        ? const Icon(
                            Icons.cloud_download,
                            size: 30,
                            color: errorColor1,
                          )
                        : const Icon(
                            Icons.cloud_done,
                            size: 30,
                            color: successColor,
                          ),
              )),
          // Obx(() => SyncTile(
          //       title: 'Free Rooms',
          //       lastUpdate: controller.lastUpdate.value,
          //       icon: controller.freeroomsSyncStatus.value
          //           ? const SpinKitChasingDots(
          //               color: primaryColor,
          //               size: 30.0,
          //             )
          //           : const Icon(
          //               Icons.cloud_done,
          //               size: 30,
          //               color: successColor,
          //             ),
          //     )),
          SizedBox(
            height: Constants.defaultPadding,
          ),
          ElevatedButton(
              onPressed: () async {
                if (controller.clickable.value) {
                  controller.syncData();
                } else {
                  GetXUtilities.snackbar(
                      title: 'Working!',
                      message: 'Synchornization in processing',
                      gradient: primaryGradient);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Constants.defaultPadding * 1.3,
                    horizontal: Constants.defaultPadding * 2),
                child: Text(
                  'Sync',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )),
          SizedBox(
            height: Constants.defaultPadding * 2,
          ),
          Obx(() => Container(
                child: controller.clickable.value
                    ? SizedBox()
                    : Column(
                        children: [
                          const SpinKitFadingCircle(
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: Constants.defaultPadding,
                          ),
                          Text(
                            'Fetching Data From Internet...',
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      ),
              ))
        ],
      ),
    );
  }
}

class SyncTile extends StatelessWidget {
  final title;
  final lastUpdate;
  final icon;

  const SyncTile(
      {Key? key, required this.title, this.lastUpdate, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widgetColor,
      elevation: Constants.defaultElevation,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding + 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w900)
                // .copyWith(fontWeight: FontWeight.bold),
                ),
            Row(children: [
              Text(
                "Last Update: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 4,
              ),
              lastUpdate == ''
                  ? Text(
                      "No Records",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : Text(
                      "$lastUpdate",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
              Padding(
                padding: EdgeInsets.only(
                    left: Constants.defaultPadding * 2,
                    right: Constants.defaultPadding),
                child: icon,
              )
            ])
          ],
        ),
      ),
    );
  }
}
