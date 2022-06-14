import 'dart:ui';

import 'package:cui_timetable/app/modules/timetable/controllers/comparision_ui_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ComparisionUiView extends GetView<ComparisionUiController> {
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
    // var height = MediaQuery.of(context).size.height / 4;

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
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  controller: controller.textController,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.textController.clear();
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
              suggestionsCallback: (pattern) async {
                if (pattern.isEmpty) return [];
                // if (controller.teachers.contains(pattern)) return [];
                return controller.teachers.where((element) => element
                    .toString()
                    .toLowerCase()
                    .contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.toString()),
                  dense: true,
                );
              },
              onSuggestionSelected: (suggestion) {
                controller.textController.text = suggestion.toString();
                List list =
                    controller.box.get(suggestion.toString().toLowerCase());
                print(list);
                final sections = <String>{};
                list.forEach((element) {
                  sections.add(element[0]);
                });

                controller.respectiveSections.value = sections.toList();
                // controller.respectiveSections.value.setAll(0, [' ']);
                // print(controller.respectiveSections.value);
              },
            ),
            SizedBox(
              height: Constants.defaultPadding * 2,
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
                padding: EdgeInsets.all(Constants.defaultPadding / 2),
                child: Obx(() => DropdownButton(
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
                Get.toNamed(Routes.COMPARISION);
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
