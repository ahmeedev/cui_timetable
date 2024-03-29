// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cui_timetable/app/modules/booking/bookingDetails/controllers/booking_details_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/freerooms/controllers/freerooms_controller.dart';
import 'package:cui_timetable/app/modules/freerooms/models/freerooms_model.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

class DayTile extends GetView<FreeroomsController> {
  final String day;
  final String dayKey;
  final Function callback;
  final Rx<bool> obs;
  const DayTile(
      {required this.day,
      required this.dayKey,
      required this.callback,
      required this.obs,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: 1,
          child: Card(
            color: widgetColor,
            elevation: Constants.defaultElevation / 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Obx(() => Container(
                  decoration: BoxDecoration(
                      color: obs.value ? selectionColor : widgetColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        callback();
                        controller.getFreerooms(day: day);
                        obs.value = true;
                        // controller.
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text(day,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: Constants.defaultPadding * 3),
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     width: double.infinity,
                          //     height: 5,
                          //     decoration: const BoxDecoration(
                          //         gradient:
                          //             LinearGradient(colors: successGradient)),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                )),
          )),
    );
  }
}

class FreeroomsMainExpansionTile extends StatelessWidget {
  final String slot;
  final bool expanded;
  final totalClasses;
  final List<FreeroomsSubClass> classes;
  final totalLabs;
  final labs;

  const FreeroomsMainExpansionTile(
      {Key? key,
      required this.slot,
      required this.totalClasses,
      required this.classes,
      required this.totalLabs,
      required this.labs,
      required this.expanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: widgetColor,
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
        child: ExpansionTile(
          initiallyExpanded: expanded,
          maintainState: true,
          leading: ImageIcon(
            const AssetImage('assets/freerooms/timer.png'),
            size: Constants.iconSize,
            // color: primaryColor,
          ),
          childrenPadding: EdgeInsets.all(Constants.defaultPadding / 2),
          collapsedBackgroundColor: widgetColor,
          backgroundColor: expandedColor,
          iconColor: primaryColor,
          title: Text(
            slot,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),
          ),
          children: [
            FreeroomsClassesExpensionTile(
              totalClasses: totalClasses,
              classes: classes,
            ),

            FreeroomsLabsExpensionTile(
              totalLabs: totalLabs,
              labs: labs,
            )
            // FreeroomsLabsExpensionTile(),
          ],
        ),
      ),
    );
  }
}

class FreeroomsClassesExpensionTile extends StatelessWidget {
  final dept = ['A', 'B', 'C', 'W'];
  final totalClasses;
  final List<FreeroomsSubClass> classes;

  FreeroomsClassesExpensionTile(
      {Key? key, required this.totalClasses, required this.classes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
        child: ExpansionTile(
          collapsedBackgroundColor: widgetColor,
          backgroundColor: selectionColor,
          onExpansionChanged: (value) {},
          title: Text(
            'Classes',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: Constants.defaultPadding / 3),
            child: Text(
              totalClasses.toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
          ),
          children: [
            ...List.generate(
                dept.length,
                (index) => FreeroomsDepartmentWiseExpensionTile(
                      department: dept[index],
                      totalClasses: classes[index].totalClasses,
                      availableClasses: classes[index].classes,
                    )),
            SizedBox(
              height: Constants.defaultPadding,
            )
          ],
        ),
      ),
    );
  }
}

class FreeroomsLabsExpensionTile extends StatelessWidget {
  final totalLabs;
  final List labs;
  final List<String> bookedLabs;
  const FreeroomsLabsExpensionTile(
      {Key? key,
      required this.totalLabs,
      required this.labs,
      this.bookedLabs = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
        child: ExpansionTile(
          collapsedBackgroundColor: widgetColor,
          backgroundColor: selectionColor,
          onExpansionChanged: (value) {},
          title: Text(
            'Labs',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: Constants.defaultPadding / 3),
            child: Text(
              '$totalLabs',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(Constants.defaultPadding),
              child: totalLabs == 0
                  ? Card(
                      shadowColor: shadowColor,
                      elevation: Constants.defaultElevation,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Constants.defaultRadius))),
                      child: Padding(
                        padding: EdgeInsets.all(
                          Constants.defaultPadding,
                        ),
                        child: Text('All Labs Reserved',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: errorColor1)),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: labs.length,
                      itemBuilder: (context, index) {
                        return LabShowCard(
                          lab: labs[index].toString(),
                          bookedLabs: bookedLabs,
                          isBookingCard: false,
                        );
                      },
                    ),
              // : GridView.count(
              //     crossAxisCount: 2,
              //     physics: const ScrollPhysics(),
              //     shrinkWrap: true,
              //     // crossAxisCount: 2,
              //     padding: EdgeInsets.zero,

              //     scrollDirection: Axis.vertical,
              //     children: [
              //       ...List.generate(labs.length,
              //           (index) => Text(labs[index].toString()))
              //     ],
              //   ),
            ),
          ],
        ),
      ),
    );
  }
}

class FreeroomsDepartmentWiseExpensionTile extends StatelessWidget {
  final department;
  final int totalClasses;
  final List availableClasses;
  final bool initialExpanded;
  final bool isBookingCard;
  final List<String> bookedRooms;
  const FreeroomsDepartmentWiseExpensionTile({
    Key? key,
    required this.department,
    required this.totalClasses,
    required this.availableClasses,
    this.initialExpanded = false,
    this.isBookingCard = false,
    this.bookedRooms = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
      child: Card(
        shadowColor: shadowColor,
        elevation: Constants.defaultElevation,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius))),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius)),
          child: ExpansionTile(
            collapsedBackgroundColor: widgetColor,
            backgroundColor: expandedColor,
            initiallyExpanded: initialExpanded,
            onExpansionChanged: (value) {},
            title: Text(
              '$department Dept.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: Padding(
              padding: EdgeInsets.only(top: Constants.defaultPadding / 3),
              child: Text(
                '$totalClasses',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(Constants.defaultPadding / 2),
                child: availableClasses.isEmpty
                    ? Card(
                        shadowColor: shadowColor,
                        elevation: Constants.defaultElevation,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Constants.defaultRadius))),
                        child: Padding(
                          padding: EdgeInsets.all(
                            Constants.defaultPadding,
                          ),
                          child: Text('All Classes Reserved',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: errorColor1)),
                        ),
                      )
                    : GridView.count(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        scrollDirection: Axis.vertical,
                        children: [
                          ...List.generate(
                              availableClasses.length,
                              (index) => RoomShowCard(
                                    room: availableClasses[index].toString(),
                                    isBookingCard: isBookingCard,
                                    bookedRooms: bookedRooms,
                                  ))
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomShowCard extends StatelessWidget {
  final String room;
  var isSelected = false.obs;

  final isBookingCard;
  final List<String> bookedRooms;
  RoomShowCard({
    Key? key,
    required this.room,
    required this.isBookingCard,
    this.bookedRooms = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          isSelected.value = true;
          if (!isBookingCard) {
            Get.defaultDialog(
                title: 'Room',
                middleText: room,
                titleStyle: const TextStyle(color: Colors.black));
          } else {
            if (bookedRooms.contains(room)) {
              Get.defaultDialog(
                  title: room,
                  middleText: "Room is already Booked",
                  titleStyle: const TextStyle(color: Colors.black));
            } else {
              Get.defaultDialog(
                  onWillPop: () => Future.value(false),
                  title: 'Room',
                  middleText: room,
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.find<BookingDetailsController>().bookingRoom.value =
                        room;
                    Get.close(2);
                  },
                  onCancel: () {
                    isSelected.value = false;
                  },
                  titleStyle: const TextStyle(color: Colors.black));
            }
          }
        },
        child: Card(
          color: widgetColor,
          elevation: Constants.defaultElevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.defaultRadius))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.defaultPadding),
                  child: Text(
                    room.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              bookedRooms.contains(room)
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        // width: 10,
                        // height: 20,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Constants.defaultRadius),
                              bottomRight:
                                  Radius.circular(Constants.defaultRadius),
                            )),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Booked",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                          ).paddingAll(Constants.defaultPadding / 2),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class LabShowCard extends StatelessWidget {
  final String lab;
  var isSelected = false.obs;
  final isBookingCard;
  final List<String> bookedLabs;
  LabShowCard({
    Key? key,
    required this.lab,
    required this.isBookingCard,
    this.bookedLabs = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          if (!isBookingCard) {
            Get.defaultDialog(
                title: 'Lab',
                middleText: lab,
                titleStyle: const TextStyle(color: Colors.black));
          } else {
            if (bookedLabs.contains(lab)) {
              Get.defaultDialog(
                  title: lab,
                  middleText: "Lab is already Booked",
                  titleStyle: const TextStyle(color: Colors.black));
            } else {
              Get.defaultDialog(
                  onWillPop: () => Future.value(false),
                  title: 'Lab',
                  middleText: lab,
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.find<BookingDetailsController>().bookingRoom.value =
                        lab;
                    Get.close(2);
                  },
                  onCancel: () {
                    isSelected.value = false;
                  },
                  titleStyle: const TextStyle(color: Colors.black));
            }
          }
        },
        child: Card(
          color: widgetColor,
          elevation: Constants.defaultElevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.defaultRadius))),
          child: Stack(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  lab.toString(),
                  // textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w900, color: Colors.black),
                ).paddingAll(Constants.defaultPadding * 2),
              ),
              bookedLabs.contains(lab)
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        // width: 10,
                        // height: 20,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(Constants.defaultRadius),
                              bottomLeft:
                                  Radius.circular(Constants.defaultRadius),
                            )),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Booked",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                          ).paddingAll(Constants.defaultPadding / 2),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
