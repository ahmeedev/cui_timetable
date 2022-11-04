import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import '../controllers/booking_info_controller.dart';
import 'widgets/booking_info_view_widgets.dart';

class BookingInfoView extends GetView<BookingInfoController> {
  const BookingInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MakeUp Availability'),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: controller.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: Get.height * 0.14,
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    // scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(5, (index) {
                        return BookingInfoDayTile(
                          day: controller.daysName[index],
                          // dayKey: controller.days[index],
                          state: controller.dayTileState[index],
                          index: index,
                          // callback: controller.allFalse,
                          // obs: controller.giveValue(index),
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() => controller
                          .dayWiseFreeLectures[
                              controller.currentActiveIndex.value]
                          .isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              // color: successColor,
                              elevation: 10,
                              child: Column(
                                children: [
                                  Text(
                                    "Availability slots for makeup classes",
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: theme
                                              .textTheme.titleLarge!.fontSize! -
                                          4,
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "[${controller.teacher} / ${controller.section} ]",
                                      textAlign: TextAlign.center,
                                      style:
                                          theme.textTheme.titleLarge!.copyWith(
                                        color: successColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: theme.textTheme.titleLarge!
                                                .fontSize! -
                                            4,
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingAll(Constants.defaultPadding * 2),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller
                                    .dayWiseFreeLectures[
                                        controller.currentActiveIndex.value]
                                    .length,
                                // itemExtent: 1.0,

                                itemBuilder: (BuildContext context, int index) {
                                  return BookingInfoLectureTile(index: index);
                                },
                              ),
                            ),
                          ],
                        ).paddingSymmetric(
                          horizontal: Constants.defaultPadding,
                          vertical: Constants.defaultPadding,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageIcon(
                              AssetImage('assets/timetable/free_lectures.png'),
                              size: 150,
                              color: primaryColor,
                            ),
                            kWidth,
                            kWidth,
                            Text(
                              "No Free Lectures today",
                              style: theme.textTheme.titleLarge!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        )),
                ),
              ],
            );
            // return Text(snapshot.data["10000"].toString());
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
