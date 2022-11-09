import 'package:cui_timetable/app/modules/booking/bookingDetails/controllers/booking_details_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';
import '../../../bookingInfo/controllers/booking_info_controller.dart';

class BookingDetailsStepperWidget extends GetView<BookingDetailsController> {
  const BookingDetailsStepperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headingStyle = theme.textTheme.titleLarge!.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w900,
        fontSize: theme.textTheme.titleLarge!.fontSize! - 5);
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Row(
              children: [
                Text("Booking by:     ", style: headingStyle),
                Text(
                  controller.bookingBy,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Row(
              children: [
                Text("Booking for:    ", style: headingStyle),
                Text(
                  controller.bookingFor,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Row(
              children: [
                Text("Booking Day:  ", style: headingStyle),
                Text(
                  controller.timeMap[controller.bookingDay.toString()]
                      .toString(),
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Row(
              children: [
                Text("Booking Date:  ", style: headingStyle),
                Text(
                  DateFormat.yMMMMd('en_US').format(DateTime.now()).toString(),
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text("Booking slot:  ", style: headingStyle),
                  Text(
                    "${controller.bookingSlot.toString()}  -  ",
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "[${Get.find<BookingInfoController>().currentTimeSlots[controller.bookingSlot - 1]}]",
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: successColor, fontWeight: FontWeight.w900),
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
                Text("Booking Room:  ", style: headingStyle),
                // FittedBox(
                //     fit: BoxFit.scaleDown,
                //     child: Text(
                //       "No room selected",
                //       style: theme.textTheme.titleMedium!.copyWith(
                //           color: errorColor1, fontWeight: FontWeight.w900),
                //     )),
                // ),
                const Spacer(),
                // const Text("C1"),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.BOOKING_ROOM);
                  },
                  child: Text(
                    "Select",
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BookingFinalizeStepperWidget extends GetView<BookingDetailsController> {
  const BookingFinalizeStepperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Card(
        child: ListTile(
          leading: FittedBox(
            fit: BoxFit.scaleDown,
            child: SpinKitFadingCube(
              color: primaryColor,
              size: Constants.iconSize,
            ),
          ),
          title: Text(
            "Checking Room Availability and reserving for you...",
            style: theme.textTheme.titleMedium!
                .copyWith(color: successColor, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      Card(
        child: Obx(() => ListTile(
              leading: controller.notificationSent.value
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      // child: SpinKitFadingCube(
                      //   color: primaryColor,
                      //   size: Constants.iconSize,
                      // ),
                      child: Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: Constants.iconSize,
                      ))
                  : FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SpinKitFadingCube(
                        color: primaryColor,
                        size: Constants.iconSize,
                      ),
                    ),
              title: Text(
                "Notifying Admin",
                style: theme.textTheme.titleMedium!.copyWith(
                    color: controller.notificationSent.value
                        ? successColor
                        : primaryColor,
                    fontWeight: FontWeight.w900),
              ),
            )),
      ),
    ]);
  }
}

class BookingStatusStepperWidget extends StatelessWidget {
  const BookingStatusStepperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Card(
        child: ListTile(
          leading: FittedBox(
              fit: BoxFit.scaleDown,
              // child: SpinKitFadingCube(
              //   color: primaryColor,
              //   size: Constants.iconSize,
              // ),
              child: Icon(
                Icons.check_circle,
                color: successColor,
                size: Constants.iconSize,
              )),
          title: Text(
            "Your request has been sent to admin and accepted!",
            style: theme.textTheme.titleMedium!
                .copyWith(color: successColor, fontWeight: FontWeight.w900),
          ),
        ),
      )
    ]);
  }
}
