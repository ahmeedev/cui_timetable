import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';

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
              if (snapshot.data == "49082b2b795ad0e7") {
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
                        ],
                      ),
                    ),
                  ],
                ).paddingAll(16);
              }
              return Center(
                  child: Text(
                "This screen show content on the development mode only.",
                textAlign: TextAlign.center,
                style:
                    theme.textTheme.titleLarge!.copyWith(color: Colors.black),
              ));
            } else {
              return const CircularProgressIndicator();
            }
            // return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
