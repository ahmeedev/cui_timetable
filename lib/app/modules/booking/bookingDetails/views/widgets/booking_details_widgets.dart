import 'package:cui_timetable/app/modules/booking/bookingDetails/controllers/booking_details_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

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
            title: FittedBox(
              fit: BoxFit.fill,
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
            // contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0.5,
            // style: ListTileStyle.list,

            leading: Text(
              "Booking Date:  ",
              style: headingStyle,
              // textAlign: TextAlign.center,
            ),

            title: Obx(() => Text(controller.bookingDatePlaceholder.value,
                style: theme.textTheme.titleMedium!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w900))),
            trailing: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.BOOKING_DATE);
                  // controller.selectDate(context);
                },
                child: controller.bookingRoom.value.isEmpty
                    ? Text(
                        "Select",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      )
                    : const Icon(Icons.change_circle)),
          ),
        ),
        // Card(
        //   child: ListTile(
        //     title: Row(
        //       children: [
        //         Text("Booking Date:  ", style: headingStyle),
        //         // Text(
        //         //   DateFormat.yMMMMd('en_US').format(DateTime.now()).toString(),
        //         //   style: theme.textTheme.titleMedium!.copyWith(
        //         //       color: Colors.black, fontWeight: FontWeight.w900),
        //         // ),
        //         // FutureBuilder<String>(
        //         //   future: controller.bookingDateFuture,
        //         //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //         //     return Text('${snapshot.data}',
        //         //         style: theme.textTheme.titleMedium!.copyWith(
        //         //             color: Colors.black, fontWeight: FontWeight.w900));
        //         //   },
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
        Card(
          child: ListTile(
            // contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0.5,
            leading: Text("Booking Room:  ", style: headingStyle),
            title: Obx(() => Text(controller.bookingRoom.value,
                style: theme.textTheme.titleMedium!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w900))),
            trailing: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.BOOKING_ROOM);
                },
                child: controller.bookingRoom.value.isEmpty
                    ? Text(
                        "Select",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      )
                    : const Icon(Icons.change_circle)),
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
          child: Obx(
        () => ListTile(
          leading: FittedBox(
            fit: BoxFit.scaleDown,
            child: controller.isRoomAvailable.value
                ? Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: Constants.iconSize,
                  )
                : controller.isBookingSuccessful.value
                    ? SpinKitFadingCube(
                        color: primaryColor,
                        size: Constants.iconSize,
                      )
                    : Icon(
                        Icons.cancel,
                        color: errorColor1,
                        size: Constants.iconSize,
                      ),
          ),
          title: Text(
            "Ensuring the room availability and reserving...",
            style: theme.textTheme.titleMedium!.copyWith(
                color: controller.isRoomAvailable.value
                    ? successColor
                    : errorColor1,
                fontWeight: FontWeight.w900),
          ),
        ),
      )),
      Card(
        child: Obx(() => ListTile(
              leading: controller.notificationSent.value
                  ? Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: Constants.iconSize,
                    )
                  : controller.isBookingSuccessful.value
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SpinKitFadingCube(
                            color: primaryColor,
                            size: Constants.iconSize,
                          ),
                        )
                      : Icon(
                          Icons.cancel,
                          color: errorColor1,
                          size: Constants.iconSize,
                        ),
              title: Text(
                "Notifying Management...",
                style: theme.textTheme.titleMedium!.copyWith(
                    color: controller.isBookingSuccessful.value
                        ? successColor
                        : errorColor1,
                    fontWeight: FontWeight.w900),
              ),
            )),
      ),
    ]);
  }
}

class BookingStatusStepperWidget extends GetView<BookingDetailsController> {
  const BookingStatusStepperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Obx(() => Card(
            child: ListTile(
              leading: controller.isBookingSuccessful.value
                  ? Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: Constants.iconSize,
                    )
                  : Icon(
                      Icons.cancel,
                      color: errorColor1,
                      size: Constants.iconSize,
                    ),
              title: Text(
                controller.isBookingSuccessful.value
                    ? "Your booking has been done. Make sure your presence in the lecture.!"
                    : "Your booking has been failed. Please try again later.",
                style: theme.textTheme.titleMedium!.copyWith(
                    color: controller.isBookingSuccessful.value
                        ? successColor
                        : errorColor1,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ))
    ]);
  }
}
