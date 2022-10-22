import 'package:cui_timetable/app/modules/comparison/controllers/sect_sect_view_controller.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';

class SectSectView extends GetView<SectSectViewController> {
  const SectSectView({Key? key}) : super(key: key);

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
              'Section1 Name',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
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

                  if (value.isEmpty || value.isEmpty) {
                    controller.listVisible.value = false;
                    controller.filteredList1.clear();
                  } else if (controller.filteredList1.contains(value) &&
                      controller.filteredList1.length == 1) {
                    controller.listVisible.value = false;
                  } else {
                    controller.listVisible.value = true;
                  }

                  // if (!controller.filteredList.contains(value)) {
                  //   controller.respectiveSections.value = [' '];
                  //   controller.dropBoxValue.value = ' ';
                  // }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.section1Controller.clear();
                        controller.filteredList1.value = [];
                        // controller.respectiveSections.value = [' '];
                        // controller.dropBoxValue.value = ' ';
                      },
                      icon: const Icon(Icons.cancel, color: primaryColor)),
                  fillColor: textFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.defaultRadius),
                      borderSide: const BorderSide(color: primaryColor)),
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
                        maxHeight: controller.listVisible.value ? height : 0,
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
            Text(
              'Section2 Name',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
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
                    controller.listVisible.value = false;
                    controller.filteredList2.clear();
                  } else if (controller.filteredList2.contains(value) &&
                      controller.filteredList2.length == 1) {
                    controller.listVisible.value = false;
                  } else {
                    controller.listVisible.value = true;
                  }

                  // if (!controller.filteredList.contains(value)) {
                  //   controller.respectiveSections.value = [' '];
                  //   controller.dropBoxValue.value = ' ';
                  // }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.section2Controller.clear();
                        controller.filteredList2.value = [];
                        // controller.respectiveSections.value = [' '];
                        // controller.dropBoxValue.value = ' ';
                      },
                      icon: const Icon(Icons.cancel, color: primaryColor)),
                  fillColor: textFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.defaultRadius),
                      borderSide: const BorderSide(color: primaryColor)),
                )),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Obx(() => controller.filteredList2.isEmpty
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
                        itemCount: controller.filteredList2.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.section2Controller.text =
                                  controller.filteredList2[index].toString();
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
              // final value = controller.textController.text.toString();
              // if (controller.teachers.contains(value)) {
              //   final box1 = await Hive.openBox(DBNames.info);
              //   box1.put(DBInfo.searchComparisonTeacher, value);

              //   Get.toNamed(Routes.COMPARISON, arguments: <String>[
              //     controller.textController.text,
              //     controller.dropBoxValue.value
              //   ]);
              // } else {
              //   GetXUtilities.snackbar(
              //       title: 'Not Found!!',
              //       message: 'Enter Valid Teacher Name',
              //       gradient: primaryGradient);
              // }
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
