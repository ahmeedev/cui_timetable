import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../routes/app_pages.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/get_widgets.dart';
import '../../controllers/sect_sect_widget_controller.dart';

class SectSectWidget extends GetView<SectSectWidgetController> {
  const SectSectWidget({Key? key}) : super(key: key);

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
              'Section_1',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            kHeight,
            TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                controller: controller.section1Controller,
                onChanged: (value) {
                  controller.filteredList1.value = controller.sections
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                  if (value.isEmpty) {
                    controller.listVisible1.value = false;
                    controller.filteredList1.clear();
                  } else if (controller.filteredList1.contains(value)) {
                    // *  && controller.filteredList1.length == 1
                    controller.listVisible1.value = false;
                  } else {
                    controller.listVisible1.value = true;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.section1Controller.clear();
                        controller.filteredList1.value = [];
                      },
                      icon: const Icon(Icons.cancel, color: primaryColor)),
                  fillColor: selectionColor,
                  filled: true,
                )),
            kHeight,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Obx(() => controller.filteredList1.isEmpty
                  ? const SizedBox()
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        maxHeight: controller.listVisible1.value ? height : 0,
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.filteredList1.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.section1Controller.text =
                                  controller.filteredList1[index].toString();

                              controller.listVisible1.value = false;
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              controller.filteredList1[index],
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
            kHeight,
            Text(
              'Section_2',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            kHeight,
            TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                controller: controller.section2Controller,
                onChanged: (value) {
                  controller.filteredList2.value = controller.sections
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                  if (value.isEmpty || value.isEmpty) {
                    controller.listVisible2.value = false;
                    controller.filteredList2.clear();
                  } else if (controller.filteredList2.contains(value)) {
                    // * && controller.filteredList2.length == 1
                    controller.listVisible2.value = false;
                  } else {
                    controller.listVisible2.value = true;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.section2Controller.clear();
                        controller.filteredList2.value = [];
                      },
                      icon: const Icon(Icons.cancel, color: primaryColor)),
                  fillColor: selectionColor,
                  filled: true,
                )),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Obx(() => controller.filteredList2.isEmpty
                  ? const SizedBox()
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        maxHeight: controller.listVisible2.value ? height : 0,
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.filteredList2.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.section2Controller.text =
                                  controller.filteredList2[index].toString();
                              controller.listVisible2.value = false;
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              controller.filteredList2[index],
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
              final section1 = controller.section1Controller.text.toString();
              final section2 = controller.section2Controller.text.toString();
              if (section1.isEmpty) {
                GetXUtilities.snackbar(
                    title: 'Error!',
                    message: 'Section 1 cannot be empty!',
                    gradient: errorGradient);
              } else if (section2.isEmpty) {
                GetXUtilities.snackbar(
                    title: 'Error!',
                    message: 'Section 2 cannot be empty!',
                    gradient: errorGradient);
              } else if (!controller.sections.contains(section1)) {
                GetXUtilities.snackbar(
                    title: 'Error!',
                    message: 'Section 1 is invalid!',
                    gradient: errorGradient);
              } else if (!controller.sections.contains(section2)) {
                GetXUtilities.snackbar(
                    title: 'Error!',
                    message: 'Section 2 is invalid!',
                    gradient: errorGradient);
              } else if (section1==section2) {
                GetXUtilities.snackbar(
                    title: 'Error!',
                    message: 'Both sections must be different',
                    gradient: errorGradient);
              }

              else {
                final box = await Hive.openBox(DBNames.comparisonCache);
                box.put(DBComparisonCache.section1, section1);
                box.put(DBComparisonCache.section2, section2);

                Get.toNamed(Routes.SEC_SEC,
                    arguments: {"section1": section1, "section2": section2});
              }
            },
            child: Padding(
              padding: EdgeInsets.all(Constants.defaultPadding),
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Text('Compare',
                    style: Theme.of(context).textTheme.labelLarge
                    // .copyWith(fontSize: 16),
                    ),
              ),
            )),
      ),
    );
  }
}
