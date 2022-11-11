import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import '../controllers/booking_info_controller.dart';
import 'widgets/booking_info_view_widgets.dart';

class BookingInfoView extends StatefulWidget {
  const BookingInfoView({Key? key}) : super(key: key);

  @override
  State<BookingInfoView> createState() => _BookingInfoViewState();
}

class _BookingInfoViewState extends State<BookingInfoView> {
  late final future;
  @override
  void initState() {
    future = Get.find<BookingInfoController>().calculate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MakeUp Availability'),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: future,
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
                          day:
                              Get.find<BookingInfoController>().daysName[index],
                          // dayKey: controller.days[index],
                          state: Get.find<BookingInfoController>()
                              .dayTileState[index],
                          index: index,
                          // callback: controller.allFalse,
                          // obs: controller.giveValue(index),
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() => Get.find<BookingInfoController>()
                          .dayWiseFreeLectures[Get.find<BookingInfoController>()
                              .currentActiveIndex
                              .value]
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
                                      "[${Get.find<BookingInfoController>().teacher} / ${Get.find<BookingInfoController>().section} ]",
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
                                itemCount: Get.find<BookingInfoController>()
                                    .dayWiseFreeLectures[
                                        Get.find<BookingInfoController>()
                                            .currentActiveIndex
                                            .value]
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
          return const Center(
            child: SpinKitFadingCube(
              color: primaryColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
