import 'package:cui_timetable/app/modules/comparison/sec_sec/controllers/sec_sec_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';

class DayTile extends GetView<SecSecController> {
  // late final String day;
  final String dayKey;
  // late final Function callback;

  const DayTile({
    // required this.day,
    required this.dayKey,
    // required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: 1,
          child: Card(
              color: widgetColor,
              shadowColor: shadowColor,
              // elevation: obs.value
              //     ? Constants.defaultElevation
              //     : Constants.defaultElevation / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.defaultRadius)),
              child: Container(
                decoration: BoxDecoration(
                    // color: obs.value ? selectionColor : widgetColor,
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
                      // callback();
                      // if (dayKey == "1") {
                      //   controller.currentTimeSlots = controller.friSlots;
                      // } else {
                      //   controller.currentTimeSlots =
                      //       controller.monToThursSlots;
                      // }
                      // controller.getLectures(key: dayKey);
                      // obs.value = true;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Text(day,
                        //     style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          controller.results[dayKey]!.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        controller.results[dayKey.toString()]!.isEmpty
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
                                          .results[dayKey]!.length
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
              ))),
    );
  }
}
