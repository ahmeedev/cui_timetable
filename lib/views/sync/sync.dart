import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:cui_timetable/controllers/sync/sync_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:path_provider/path_provider.dart';

class Sync extends StatelessWidget {
  Sync({Key? key}) : super(key: key);
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

class SyncBody extends StatelessWidget {
  SyncBody({Key? key}) : super(key: key);
  final syncController = SyncController();

  final lastUpdate = '15-apr-2022';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => SyncTile(
              title: 'Timetable',
              lastUpdate: lastUpdate,
              icon: syncController.stillSync.value
                  ? const GFLoader(
                      loaderColorOne: Colors.red,
                      loaderColorTwo: Colors.blue,
                      loaderColorThree: Colors.yellow,
                    )
                  : const Icon(Icons.cloud),
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
              await syncController.syncData();

              Get.showSnackbar(const GetSnackBar(
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  title: 'Sync in progress',
                  messageText: Text('This is message')));
            },
            child: const Text('Sync')),
        // Expanded(
        //   child: ListView(
        //     children: [
        //       Obx(
        //         () => Text(syncController.data.toString()),
        //       ),
        //     ],
        //   ),
        // )
      ],
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
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(children: [Text("Last Update: $lastUpdate"), icon])
          ],
        ),
      ),
    );
  }
}
