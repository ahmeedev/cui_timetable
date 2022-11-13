import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/booking_details_view_controller.dart';

class BookingDetailsViewView extends GetView<BookingDetailsViewController> {
  const BookingDetailsViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headingStyle = theme.textTheme.titleLarge!.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w900,
        fontSize: theme.textTheme.titleLarge!.fontSize! - 5);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking Details'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                    style: theme.textTheme.labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              Text("Initiate Timestamp:  ",
                                  style: headingStyle),
                              Text(
                                DateFormat.yMMMMEEEEd().add_jm().format(
                                    DateTime.parse(controller.timestamp)),
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text("Booking slot:           ",
                                style: headingStyle),
                            Text(
                              "${controller.slot}  -  ",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "[${controller.currentTimeSlots[controller.slot - 1]}]",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: successColor,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text("Booking Room:      ", style: headingStyle),
                            Text(
                              "${controller.room}",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text("Booking Section:   ", style: headingStyle),
                            Text(
                              "${controller.section}",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingAll(Constants.defaultPadding);
              }
              return const Center(
                child: SpinKitFadingCube(
                  color: primaryColor,
                  size: 30.0,
                ),
              );
            }));
  }
}
