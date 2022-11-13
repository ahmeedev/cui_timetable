import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/booking/controllers/booking_log_controller.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

class BookingLog extends GetView<BookingLogController> {
  const BookingLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.getLogs(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data() ?? {};
            final keys = data.keys.toList();

            keys.sort((a, b) {
              //sorting in ascending order
              return DateTime.parse(b).compareTo(DateTime.parse(a));
            });

            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No booking Logs found',
                  style:
                      theme.textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
              );
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final status = data[keys[index]]["status"];
                  String msg = "";
                  if (status) {
                    msg =
                        "Booking for ${data[keys[index]]["section"]} in room ${data[keys[index]]["room"]} has been done.";
                  } else {
                    msg =
                        "Booking for ${data[keys[index]]["section"]} in room ${data[keys[index]]["room"]} has been rejected.";
                  }
                  return Card(
                    child: ListTile(
                      title: Text(
                        msg,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: status ? successColor : errorColor1,
                            fontWeight: FontWeight.w900),
                      ).paddingOnly(bottom: Constants.defaultPadding),
                      // minVerticalPadding: Constants.defaultPadding,
                      contentPadding: EdgeInsets.all(Constants.defaultPadding),
                      subtitle: Row(children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.CANCEL_BOOKING, arguments: {
                                "timestamp": keys[index],
                                "section": data[keys[index]]["section"],
                                "room": data[keys[index]]["room"],
                                "slot": data[keys[index]]["slot"],
                                "date": data[keys[index]]["date"],
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: errorColor1),
                            child: const Text("Cancel booking")),
                        kWidth,
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.BOOKING_DETAILS_VIEW,
                                  arguments: {
                                    "timestamp": keys[index],
                                    "section": data[keys[index]]["section"],
                                    "room": data[keys[index]]["room"],
                                    "slot": data[keys[index]]["slot"],
                                  });
                            },
                            child: const Text("View Details")),
                        // kWidth,
                      ]),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            GetXUtilities.snackbar(
                title: "Error!",
                message: 'An error occured!',
                gradient: errorGradient);
          }

          return SpinKitFadingCube(
            color: primaryColor,
            size: Constants.iconSize,
          );
        }).paddingAll(Constants.defaultPadding);
  }
}

//
