import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/booking/controllers/booking_log_controller.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../controllers/booking_controller.dart';

class BookingLog extends GetView<BookingLogController> {
  const BookingLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.getLogs(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data() ?? {};
            final keys = data.keys.toList();

            keys.sort((a, b) {
              //sorting in ascending order
              return DateTime.parse(b).compareTo(DateTime.parse(a));
            });

            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No booking Logs found',
                  style:
                      theme.textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
              );
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final status = data[keys[index]]["status"];
                  String msg = "";
                  if (status) {
                    msg =
                        "Booking for ${data[keys[index]]["section"]} in room ${data[keys[index]]["room"]} has been done.";
                  } else {
                    msg =
                        "Booking for ${data[keys[index]]["section"]} in room ${data[keys[index]]["room"]} has been rejected.";
                  }
                  //! if date is elapsed the check the status, if status pass then it means that the booking is cancelled, if not then it means that the
                  //! booking time is elapsed, and if the date is not elapsed then check that the status is true, if true show the elevated buttons otherwise,
                  //! it means, that the booking was cancelled before the date has elapsed.
                  return Card(
                    child: ListTile(
                      title: Text(
                        msg,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: status ? successColor : errorColor1,
                            fontWeight: FontWeight.w900),
                      )
                          .paddingAll(Constants.defaultPadding)
                          .paddingOnly(bottom: Constants.defaultPadding / 2),
                      // minVerticalPadding: Constants.defaultPadding,
                      // contentPadding:
                      //     EdgeInsets.all(Constants.defaultPadding),
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      subtitle: DateTime.parse(data[keys[index]]["date"])
                              .isBefore(DateTime.now())
                          ? status == false
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: errorColor1,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              Constants.defaultRadius / 2),
                                          bottomRight: Radius.circular(
                                              Constants.defaultRadius / 2))),
                                  child: Text(
                                    "Booking Cancelled",
                                    style: theme.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ).paddingAll(Constants.defaultPadding),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              Constants.defaultRadius / 2),
                                          bottomRight: Radius.circular(
                                              Constants.defaultRadius / 2))),
                                  child: Text(
                                    "Booking has been Expired!",
                                    style: theme.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ).paddingAll(Constants.defaultPadding),
                                )
                          : status
                              ? Row(children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.CANCEL_BOOKING,
                                            arguments: {
                                              "timestamp": keys[index],
                                              "section": data[keys[index]]
                                                  ["section"],
                                              "room": data[keys[index]]["room"],
                                              "slot": data[keys[index]]["slot"],
                                              "date": data[keys[index]]["date"],
                                            });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: errorColor1),
                                      child: const Text("Cancel booking")),
                                  kWidth,
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.BOOKING_DETAILS_VIEW,
                                            arguments: {
                                              "timestamp": keys[index],
                                              "section": data[keys[index]]
                                                  ["section"],
                                              "room": data[keys[index]]["room"],
                                              "slot": data[keys[index]]["slot"],
                                              "date": data[keys[index]]["date"],
                                            });
                                      },
                                      child: const Text("View Details")),
                                  // kWidth,
                                ]).paddingSymmetric(
                                  horizontal: Constants.defaultPadding)
                              : Container(
                                  decoration: BoxDecoration(
                                      color: errorColor1,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              Constants.defaultRadius / 2),
                                          bottomRight: Radius.circular(
                                              Constants.defaultRadius / 2))),
                                  child: Text(
                                    "Booking Cancelled",
                                    style: theme.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ).paddingAll(Constants.defaultPadding),
                                ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            GetXUtilities.snackbar(
                title: "Error!",
                message: 'An error occured!',
                gradient: errorGradient);
          }

          return SpinKitFadingCube(
            color: primaryColor,
            size: Constants.iconSize,
          );
        }).paddingAll(Constants.defaultPadding);
  }
}

class BookingWidget extends GetView<BookingController> {
  const BookingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldColor,
        // appBar: AppBar(
        //   title: const Text('Booking'),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(context),
              kHeight,
              _buildButton(context)
            ],
          ),
        ));
  }

// Build the textfield portion.
  Card _buildTextField(context) {
    var height = MediaQuery.of(context).size.height / 4;

    return Card(
      color: widgetColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
      ),
      elevation: Constants.defaultElevation,
      shadowColor: shadowColor,
      child: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Constants.defaultPadding,
            ),
            Text(
              'Teacher Name',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                controller: controller.textController,
                onChanged: (value) {
                  controller.filteredList.value = controller.teachers
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                  if (value.isEmpty || value.isEmpty) {
                    controller.listVisible.value = false;
                    controller.filteredList.clear();
                  } else if (controller.filteredList.contains(value) &&
                      controller.filteredList.length == 1) {
                    controller.listVisible.value = false;
                  } else {
                    controller.listVisible.value = true;
                  }

                  if (!controller.filteredList.contains(value)) {
                    controller.respectiveSections.value = [' '];
                    controller.dropBoxValue.value = ' ';
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.textController.clear();
                        controller.filteredList.value = [];
                        controller.respectiveSections.value = [' '];
                        controller.dropBoxValue.value = ' ';
                      },
                      icon: const Icon(Icons.cancel, color: primaryColor)),
                  fillColor: selectionColor,
                  filled: true,
                )),
            kHeight,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Obx(() => controller.filteredList.isEmpty
                  ? const SizedBox()
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        maxHeight: controller.listVisible.value ? height : 0,
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.filteredList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.listTileTap(index: index);
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              controller.filteredList[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: primaryColor,
                            height: 2,
                            // indent: 15,
                            // endIndent: 15,
                          );
                        },
                      ),
                    )),
            ),
            kHeight,
            Text(
              'Select Section',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(Constants.defaultPadding * 1.2, 0,
                    Constants.defaultPadding * 2, 0),
                child: Obx(() => DropdownButton(
                      focusColor: selectionColor,
                      isExpanded: true,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constants.defaultRadius)),
                      dropdownColor: widgetColor,
                      style: Theme.of(context).textTheme.titleMedium,
                      underline: Container(
                        height: 2,
                        color: primaryColor,
                      ),
                      // Initial Value
                      // ignore: unrelated_type_equality_checks
                      value: controller.dropBoxValue == ' '
                          ? controller.respectiveSections[0]
                          : controller.dropBoxValue.value,

                      onChanged: (value) {
                        controller.dropBoxValue.value = value.toString();
                      },

                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconEnabledColor: primaryColor,

                      items: controller.respectiveSections.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                    ))),
          ],
        ),
      ),
    );
  }

// Build the button portion.
  Padding _buildButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: IntrinsicWidth(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            onPressed: () async {
              final value = controller.textController.text.toString();
              if (controller.teachers.contains(value)) {
                final box1 = await Hive.openBox(DBNames.bookingCache);
                box1.put(DBBookingCache.searchTeacher, value);

                Get.toNamed(Routes.BOOKING_INFO, arguments: {
                  "teacher": controller.textController.text,
                  "section": controller.dropBoxValue.value
                });
              } else {
                GetXUtilities.snackbar(
                    title: 'Not Found!!',
                    message: 'Enter Valid Teacher Name',
                    gradient: primaryGradient);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(Constants.defaultPadding),
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Text('Find Now',
                    style: Theme.of(context).textTheme.labelLarge
                    // .copyWith(fontSize: 16),
                    ),
              ),
            )),
      ),
    );
  }
}
