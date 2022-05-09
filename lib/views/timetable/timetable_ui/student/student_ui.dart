import 'package:cui_timetable/controllers/database/db_constants.dart';
import 'package:cui_timetable/controllers/timetable/student/student_ui_controller.dart';

import 'package:cui_timetable/style.dart';
import 'package:cui_timetable/views/timetable/timetable_ui/student/student_timetable.dart';
import 'package:cui_timetable/views/utilities/get_utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentUI extends StatelessWidget {
  final controller = Get.put(StudentUIController());

  StudentUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
              defaultPadding, defaultPadding, defaultPadding, defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(context),
              const SizedBox(
                height: 20,
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
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      elevation: defaultElevation,
      shadowColor: shadowColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Section Name',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
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
                  fillColor: textFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      borderSide: const BorderSide(color: primaryColor)),
                )),

            // const SizedBox(
            //   height: 10,
            // ),
            Obx(() => controller.filteredList.isEmpty
                ? const SizedBox()
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      maxHeight: controller.listVisible.value ? height : 0,
                    ),
                    child: ListView.separated(
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
                          height: 3,
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
              if (controller.sections
                  .contains(controller.textController.text.toString())) {
                // Storing the information for state persistency
                final box = await Hive.openBox(DBNames.info);
                box.put(DBInfo.searchSection,
                    controller.textController.text.toString());

                Get.to(() => StudentTimetable(),
                    transition: Transition.cupertino,
                    arguments: [controller.textController.text]);
              } else {
                GetXUtilities.snackbar(
                    title: 'Not Found',
                    message: 'Enter Valid Section',
                    gradient: primaryGradient);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
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
