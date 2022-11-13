import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/app_colors.dart';
import '../../controllers/cancel_booking_controller.dart';

class CancelBookingDetailsStepperWidget
    extends GetView<CancelBookingController> {
  const CancelBookingDetailsStepperWidget({Key? key}) : super(key: key);

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
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text("Initiate Timestamp:  ", style: headingStyle),
                  Text(
                    DateFormat.yMMMMEEEEd()
                        .add_jm()
                        .format(DateTime.parse(controller.timestamp)),
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text("Booking slot:          ", style: headingStyle),
                  Text(
                    "${controller.slot}  -  ",
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "[${controller.currentTimeSlots[controller.slot - 1]}]",
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
                Text("Booking Date:       ", style: headingStyle),
                // Text(
                //   DateFormat.yMMMMd('en_US').format(DateTime.now()).toString(),
                //   style: theme.textTheme.titleMedium!.copyWith(
                //       color: Colors.black, fontWeight: FontWeight.w900),
                // ),
                Text('${controller.date}',
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900))
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Row(
              children: [
                Text("Booking Room:     ", style: headingStyle),
                Text(
                  "${controller.room}",
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
                Text("Booking Section:  ", style: headingStyle),
                Text(
                  "${controller.section}",
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
