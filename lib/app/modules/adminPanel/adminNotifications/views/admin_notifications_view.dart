import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/admin_notifications_controller.dart';

class AdminNotificationsView extends GetView<AdminNotificationsController> {
  const AdminNotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: StreamBuilder<DocumentSnapshot>(
          stream: controller.stream,
          // initialData: initialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data.data() as Map<String, dynamic>;

              final List<String> notificationsKeys = data.keys.toList();
              notificationsKeys.sort((a, b) => b.compareTo(a));

              if (data.isEmpty) {
                return Center(
                  child: Text(
                    "No Notifications",
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: notificationsKeys.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    // margin: EdgeInsets.zero,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[notificationsKeys[index]]['title'],
                                style: theme.textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              // const Spacer(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              DateFormat().format(
                                  DateTime.parse(notificationsKeys[index])),
                              style: theme.textTheme.labelMedium!.copyWith(
                                  // fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ).paddingAll(Constants.defaultPadding / 2),
                      subtitle:
                          Text(data[notificationsKeys[index]]['description'])
                              .paddingAll(Constants.defaultPadding / 2),
                    ),
                  );
                },
              );
            }

            return const SpinKitFadingCube(
              color: primaryColor,
              size: 30.0,
            );
          },
        ),
      ),
    );
  }
}
