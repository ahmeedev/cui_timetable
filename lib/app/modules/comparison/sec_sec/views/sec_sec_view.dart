import 'package:cui_timetable/app/modules/comparison/sec_sec/views/widgets/sec_sec_view_widgets.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/sec_sec_controller.dart';

class SecSecView extends GetView<SecSecController> {
  const SecSecView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Lectures'),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: controller.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SizedBox(
                  height: Get.height * 0.14,
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    // scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(5, (index) {
                        return SecSecDayTile(
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
                                    "Availability of free lectures for",
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
                                      "[${controller.section1} / ${controller.section2} ]",
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
                                  return SecSecLectureTile(index: index);
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
