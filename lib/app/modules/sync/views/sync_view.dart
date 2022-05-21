// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cui_timetable/app/data/database/timetable_database.dart';
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
        title: const Text('sync'),
        centerTitle: true,
      ),
      body: SyncBody(),
    );
  }
}

class SyncBody extends GetView<SyncController> {
  const SyncBody({Key? key}) : super(key: key);

  // final lastUpdate = '15-apr-2022';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
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
                    : const Icon(
                        Icons.cloud_done,
                        size: 30,
                        color: successColor,
                      ),
              )),
          Obx(() => SyncTile(
                title: 'Free Rooms',
                lastUpdate: controller.lastUpdate.value,
                icon: controller.freeroomsSyncStatus.value
                    ? const SpinKitChasingDots(
                        color: primaryColor,
                        size: 30.0,
                      )
                    : const Icon(
                        Icons.cloud_done,
                        size: 30,
                        color: successColor,
                      ),
              )),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
              onPressed: () async {
                if (controller.clickable) {
                  controller.syncData();
                } else {
                  GetXUtilities.snackbar(
                      title: 'In Progress',
                      message: 'Synchornization in processing',
                      gradient: primaryGradient);
                }

                // await databaseController.insertTime();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding * 2),
                child: Text(
                  'Sync',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )),
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
      elevation: defaultElevation,
      shadowColor: shadowColor,
      color: widgetColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w900)
                // .copyWith(fontWeight: FontWeight.bold),
                ),
            Row(children: [
              Text(
                "Last Update: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 4,
              ),
              lastUpdate == ''
                  ? Text(
                      "No Records",
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  : Text(
                      "$lastUpdate",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
              Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding * 2, right: defaultPadding),
                child: icon,
              )
            ])
          ],
        ),
      ),
    );
  }
}
