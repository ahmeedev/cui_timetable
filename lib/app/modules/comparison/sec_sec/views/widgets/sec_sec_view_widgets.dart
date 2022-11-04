import 'package:cui_timetable/app/modules/comparison/sec_sec/controllers/sec_sec_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';
import '../../../../../widgets/global_widgets.dart';
import '../../../controllers/comparison_controller.dart';

class SecSecDayTile extends GetView<SecSecController> {
  final String day;
  // final String dayKey;
  final Rx<bool> state;
  final int index;
  // late final Function callback;

  const SecSecDayTile({
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
                        controller.currentTimeSlots =
                            Get.find<ComparisonController>().friSlots;
                      } else {
                        controller.currentTimeSlots =
                            Get.find<ComparisonController>().monToThursSlots;
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

class SecSecLectureTile extends GetView<SecSecController> {
  final int index;
  const SecSecLectureTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child:
                Text(
                  "Free Slot",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: successColor, fontWeight: FontWeight.w900),
                ).paddingSymmetric(horizontal: Constants.defaultPadding),

            ),
            const VerticalDivider(
              color: primaryColor,
              thickness: 3,
              indent: 5,
              endIndent: 5,
              width: 0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: selectionColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius)),
                    child: Center(
                      child: Text(
                        "Slot No. ${controller.dayWiseFreeLectures[controller.currentActiveIndex.value][index]}",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ).paddingAll(Constants.defaultPadding),
                    ),
                  ),
                  kHeight,
                  Card(
                    color: selectionColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.defaultRadius)),
                    child: Center(
                      child: Text(
                        "${controller.currentTimeSlots[controller.dayWiseFreeLectures[controller.currentActiveIndex.value][index] - 1]}",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ).paddingAll(Constants.defaultPadding),
                    ),
                  ),
                ],
              ).paddingAll(Constants.defaultPadding),
            ),
          ],
        ),
      ),
    ).paddingSymmetric(vertical: 2);
  }
}
