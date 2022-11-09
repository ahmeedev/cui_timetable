import 'package:cui_timetable/app/modules/booking/bookingInfo/controllers/booking_info_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';
import '../../../../../widgets/global_widgets.dart';

class BookingInfoDayTile extends GetView<BookingInfoController> {
  final String day;
  // final String dayKey;
  final Rx<bool> state;
  final int index;
  // late final Function callback;

  const BookingInfoDayTile({
    required this.day,
    // required this.dayKey,
    required this.state,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: 1,
          child: Obx(() => Card(
              color: widgetColor,
              shadowColor: shadowColor,
              // elevation: obs.value
              //     ? Constants.defaultElevation
              //     : Constants.defaultElevation / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.defaultRadius)),
              child: Container(
                decoration: BoxDecoration(
                    color: state.value ? selectionColor : widgetColor,
                    // gradient: const LinearGradient(colors: primaryGradient),
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius)),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(Constants.defaultRadius),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultRadius),
                    onTap: () {
                      controller.changeDayTileState(index: index);
                      // callback();
                      if (index == 4) {
                        controller.currentTimeSlots = controller.friSlots;
                      } else {
                        controller.currentTimeSlots =
                            controller.monToThursSlots;
                      }
                      // controller.getLectures(key: dayKey);
                      // obs.value = true;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(day,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          controller.dayWiseFreeLectures[index].length
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        controller.dayWiseFreeLectures[index].isEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.defaultPadding * 3),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: successGradient)),
                                ),
                              )
                            : Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  ...List.generate(
                                      int.parse(controller
                                          .dayWiseFreeLectures[index].length
                                          .toString()),
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                  color: colorList[index],
                                                  shape: BoxShape.circle),
                                            ),
                                          ))
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              )))),
    );
  }
}

class BookingInfoLectureTile extends GetView<BookingInfoController> {
  final int index;
  const BookingInfoLectureTile({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = controller.currentTimeSlots[
            controller.dayWiseFreeLectures[controller.currentActiveIndex.value]
                    [index] -
                1]
        .split('-');

    final slotNo = controller
        .dayWiseFreeLectures[controller.currentActiveIndex.value][index];
    return Card(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time[0],
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: successColor, fontWeight: FontWeight.w900),
                ).paddingSymmetric(horizontal: Constants.defaultPadding),
                Text(
                  "|",
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: successColor, fontWeight: FontWeight.w900),
                ).paddingSymmetric(horizontal: Constants.defaultPadding),
                Text(
                  time[1],
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: successColor, fontWeight: FontWeight.w900),
                ).paddingSymmetric(horizontal: Constants.defaultPadding),
              ],
            ),
            Container(
              color: selectionColor,
              width: 4,
              // height: 4,
              // height: double.infinity,
            ).paddingSymmetric(vertical: Constants.defaultPadding / 2),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: selectionColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius)),
                    child: Center(
                      child: Text(
                        "Slot No. $slotNo",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ).paddingAll(Constants.defaultPadding),
                    ),
                  ),
                  kHeight,
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.BOOKING_DETAILS, arguments: {
                        "bookingBy": controller.teacher,
                        "bookingFor": controller.section,
                        "bookingSlot": slotNo,
                      });
                    },
                    child: Text(
                      "Book Now",
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ).paddingAll(Constants.defaultPadding),
                  ).paddingSymmetric(horizontal: Constants.defaultPadding / 2),
                ],
              ).paddingAll(Constants.defaultPadding),
            ),
          ],
        ),
      ),
    ).paddingSymmetric(vertical: 2);
  }
}
