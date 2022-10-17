import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:hive/hive.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/get_widgets.dart';
import '../../controllers/student_ui_controlller.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentUI extends GetView<RemainderStudentUIController> {
  const StudentUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldColor,
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(context),
              SizedBox(
                height: Constants.defaultPadding,
              ),
              _buildButton(context),
              // ElevatedButton(
              //   onPressed: () async {
              //     AwesomeNotifications().cancelAllSchedules();
              //     log(DateTime.parse('2022-08-26 17:40:00Z')
              //         .toLocal()
              //         .toString());
              //     String localTimeZone =
              //         await AwesomeNotifications().getLocalTimeZoneIdentifier();
              //     AwesomeNotifications().createNotification(
              //       // actionButtons: [],
              //       // schedule: NotificationInterval(
              //       //     interval: 3, timeZone: localTimeZone),
              //       schedule: NotificationCalendar(
              //           weekday: 2,
              //           hour: 22,
              //           minute: 5,
              //           second: 30,
              //           millisecond: 0,
              //           timeZone: localTimeZone
              //           // timeZone: localTimeZone,
              //           ),
              //       content: NotificationContent(
              //         id: 1,
              //         channelKey: channelRemainderKey,
              //         notificationLayout: NotificationLayout.BigText,
              //         title: 'Remainder!',
              //         wakeUpScreen: true,
              //         category: NotificationCategory.Reminder,
              //         // backgroundColor: Colors.red,
              //         // color: Colors.green,
              //         summary: "Get ready for your next lecture",
              //         body:
              //             'your next lecture started at 10:00 am of Financial Accounting at A1',
              //       ),
              //     );
              //   },
              //   child: const Text('Store'),
              // ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Section Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                GestureDetector(
                  onTap: () async {
                    final box = await Hive.openBox(DBNames.remainderCache);
                    final List result = box
                        .get(DBRemainderCache.sectionHistory, defaultValue: []);
                    controller.sectionHistory.value = result;
                    GetXUtilities.remainderHistory(context,
                        content: controller.sectionHistory);
                  },
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding / 2,
                        vertical: Constants.defaultPadding / 3),
                    // color: Colors.red,
                    child: Icon(
                      Icons.history,
                      size: Constants.iconSize + 2,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
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
                  controller.filteredList.value = controller.sections
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
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.textController.clear();
                        controller.filteredList.value = [];
                      },
                      icon: const Icon(Icons.cancel, color: primaryColor)),
                  fillColor: textFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.defaultRadius),
                      borderSide: const BorderSide(color: primaryColor)),
                )),
            SizedBox(
              height: Constants.defaultPadding / 2,
            ),
            Obx(() => controller.filteredList.isEmpty
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
                            controller.textController.text =
                                controller.filteredList[index];
                            controller.textController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                        controller.textController.text.length));
                            controller.listVisible.value = false;
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
                  ))
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
              if (controller.sections.contains(value)) {
                Get.toNamed(Routes.STUDENT_REMAINDER,
                    arguments: {"section": value});

                final box = await Hive.openBox(DBNames.remainderCache);
                box.put(DBRemainderCache.studentSection, value);
                await box.close();
                _cacheSectionHistory(value);
              } else {
                GetXUtilities.snackbar(
                    title: 'Not Found!!',
                    message: 'Enter Valid Section Name',
                    gradient: primaryGradient);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(Constants.defaultPadding),
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Text('Set Remainder',
                    style: Theme.of(context).textTheme.labelLarge
                    // .copyWith(fontSize: 16),
                    ),
              ),
            )),
      ),
    );
  }

  _cacheSectionHistory(value) async {
    final box2 = await Hive.openBox(DBNames.remainderCache);
    List list = box2.get(DBRemainderCache.sectionHistory, defaultValue: []);
    if (list.length != 6) {
      Set result = list.toSet();
      result.add(value);
      box2.put(DBRemainderCache.sectionHistory, result.toList());
      // await box2.close();
    }
  }
}
