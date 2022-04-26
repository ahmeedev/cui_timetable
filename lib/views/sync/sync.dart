import 'package:cui_timetable/controllers/database/database_controller.dart';
import 'package:cui_timetable/controllers/sync/sync_controller.dart';
import 'package:cui_timetable/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Sync extends StatelessWidget {
  const Sync({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text('sync'),
        centerTitle: true,
      ),
      body: SyncBody(),
    );
  }
}

class SyncBody extends StatelessWidget {
  SyncBody({Key? key}) : super(key: key);
  final syncController = Get.put(SyncController());
  final databaseController = DatabaseController();

  // final lastUpdate = '15-apr-2022';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        children: [
          Obx(() => SyncTile(
                title: 'Timetable',
                lastUpdate: syncController.last_update.value,
                icon: syncController.stillSync.value
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
          // SyncTile(
          //   title: 'Datesheet',
          //   lastUpdate: lastUpdate,
          //   icon: Icons.sync,
          // ),
          // SyncTile(
          //   title: 'Free Rooms',
          //   lastUpdate: lastUpdate,
          //   icon: Icons.sync,
          // ),
          ElevatedButton(
              onPressed: () async {
                await syncController.syncData(context);
                // await databaseController.insertTime();
              },
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
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
