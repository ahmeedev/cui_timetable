import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../../widgets/get_widgets.dart';
import '../controllers/transport_controller.dart';

class TransportView extends GetView<TransportController> {
  const TransportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              Constants.defaultPadding,
              Constants.defaultPadding,
              Constants.defaultPadding,
              Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kHeight,
              kHeight,
              kHeight,
              kHeight,
              kHeight,
              _buildTextField(context),
              SizedBox(
                height: Constants.defaultPadding,
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Teacher Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                GestureDetector(
                  onTap: () async {
                    final box = await Hive.openBox(DBNames.timetableCache);
                    final List result = box
                        .get(DBTimetableCache.teacherHistory, defaultValue: []);
                    controller.dialogHistoryList.value = result;
                    GetXUtilities.historyDialog(
                        context: context,
                        content: controller.dialogHistoryList,
                        student: false);
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
                  print(value);
                  controller.filteredList.value = controller.teachers
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          // .replaceFirst("CS Mr.", '')
                          .replaceAll(' ', '')
                          .contains(value.toLowerCase()))
                      .toList();

                  if (value.isEmpty) {
                    controller.listVisible.value = false;
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
                  fillColor: selectionColor,
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
              if (controller.teachers.contains(value)) {
                // Storing the information for state persistency
                await _cacheData(value);

                Get.toNamed(Routes.TEACHER_TIMETABLE, arguments: [value]);
              } else {
                GetXUtilities.snackbar(
                    title: 'Not Found!!!',
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

  Future<void> _cacheData(String value) async {
    final box1 = await Hive.openBox(DBNames.info);
    box1.put(DBTimetableCache.teacherName,
        controller.textController.text.toString());

    // cache the history
    final box2 = await Hive.openBox(DBNames.timetableCache);
    List list = box2.get(DBTimetableCache.teacherHistory, defaultValue: []);
    if (list.length != 6) {
      Set result = list.toSet();
      result.add(value);
      box2.put(DBTimetableCache.teacherHistory, result.toList());
      // await box2.close();
    }
  }
}
