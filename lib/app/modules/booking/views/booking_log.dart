import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/booking/controllers/booking_log_controller.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

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
            final data = snapshot.data!.data()!;
            final keys = data.keys.toList();

            keys.sort((a, b) {
              //sorting in ascending order
              return DateTime.parse(b).compareTo(DateTime.parse(a));
            });

            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final status = data[keys[index]]["status"];
                  String msg = "";
                  if (status) {
                    msg =
                        "Booking with ${data[keys[index]]["section"]} in room ${data[keys[index]]["room"]} at slot ${data[keys[index]]["slot"]} has been Accepted.";
                  } else {
                    msg =
                        "Booking with ${data[keys[index]]["section"]} in room ${data[keys[index]]["room"]} at slot ${data[keys[index]]["slot"]} has been Rejected.";
                  }
                  return Card(
                    child: ListTile(
                      leading: FittedBox(
                          fit: BoxFit.scaleDown,
                          // child: SpinKitFadingCube(
                          //   color: primaryColor,
                          //   size: Constants.iconSize,
                          // ),
                          child: status
                              ? Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: Constants.iconSize,
                                )
                              : Icon(
                                  Icons.cancel_rounded,
                                  color: errorColor1,
                                  size: Constants.iconSize,
                                )),
                      title: Text(
                        msg,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: status ? successColor : errorColor1,
                            fontWeight: FontWeight.w900),
                      ),
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
