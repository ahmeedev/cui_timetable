import 'dart:developer';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/for_developer_controller.dart';

class ForDeveloperView extends GetView<ForDeveloperController> {
  const ForDeveloperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer'),
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
          future: controller.getId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // if (snapshot.data == "49082b2b795ad0e7") {
              if (snapshot.data == "W1oNbPGPgrNyfQ1n5ZW5QUsRtpb2") {
                return ListView(
                  children: [
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                                  onPressed: () async {
                                    await controller.syncAllFiles();
                                  },
                                  child:
                                      const Text("Sync Files").paddingAll(16))
                              .paddingAll(16),
                          ElevatedButton(
                                  onPressed: () async {
                                    final result =
                                        await controller.sendNotification();
                                    GetXUtilities.snackbar(
                                        duration: 3,
                                        title: 'Cloud Notification',
                                        message: result.body.toString(),
                                        gradient: successGradient);
                                    // log(result.body.toString());
                                  },
                                  child: const Text("Send Notification")
                                      .paddingAll(16))
                              .paddingAll(16),


                          ElevatedButton(
                                  onPressed: () async {

                                    final uid=FirebaseAuth.instance.currentUser!.uid;
                                    log(uid.toString(),name: 'UID',

                                    );
                                  },
                                  child: const Text("Testing")
                                      .paddingAll(16))
                              .paddingAll(16),




                        ],
                      ),
                    ),
                  ],
                ).paddingAll(16);
              }

            } else if(snapshot.hasError){
              return Center(
                  child: Text(
                    "You must be signIn as a developer.",
                    textAlign: TextAlign.center,
                    style:
                    theme.textTheme.titleMedium!.copyWith(color: Colors.black),
                  ));
            }

            return const SpinKitFadingCube(
              color: primaryColor,
              size: 30,

            );
            // return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
