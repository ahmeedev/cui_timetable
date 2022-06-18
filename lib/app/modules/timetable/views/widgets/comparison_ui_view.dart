import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/timetable/controllers/comparison_ui_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';

class ComparisonUiView extends GetView<ComparisonUiController> {
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

                  if (value.isEmpty || value.length == 0) {
                    controller.listVisible.value = false;
                    controller.filteredList.clear();
                    print("value is null");
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
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Obx(() => controller.filteredList.isEmpty
                  ? SizedBox()
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
            SizedBox(
              height: Constants.defaultPadding / 2,
            ),
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
                      focusColor: textFieldColor,
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
                final box1 = await Hive.openBox(DBNames.info);
                box1.put(DBInfo.searchComparisonTeacher, value);

                Get.toNamed(Routes.COMPARISION, arguments: <String>[
                  controller.textController.text,
                  controller.dropBoxValue.value
                ]);
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
