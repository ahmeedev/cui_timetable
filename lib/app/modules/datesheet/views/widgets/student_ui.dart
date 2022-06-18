import 'package:cui_timetable/app/data/database/datesheet_db/datesheet_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/datesheet/controllers/student_ui_controlller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

class StudentUI extends GetView<StudentUIController> {
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
              ElevatedButton(
                onPressed: () {
                  final db = DatesheetDatabase();
                  db.createDatabase();
                },
                child: Text('Download'),
              ),
              ElevatedButton(
                onPressed: () {
                  List<String> tokens = "FA21-CVE-FA19-CVE".split('-');

                  List<String> result = [];
                  var section;
                  for (var i = 0; i < tokens.length; i++) {
                    if (tokens[i].length == 4) {
                      section = "";
                      section = tokens[i] + "-";
                    } else if (tokens[i].length == 3) {
                      section += tokens[i];
                      if (i == tokens.length - 1 || tokens[i + 1].length == 4) {
                        result.add(section);
                      }
                    } else if (tokens[i].length == 1) {
                      section += "-" + tokens[i];
                      if (i != tokens.length - 1 && tokens[i + 1].length == 4) {
                        result.add(section);
                      }
                    }
                  }
                  // "asdf-add-a".split(r'-');
                  print(result);
                },
                child: Text('Token'),
              ),
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
              'Section Name',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                // controller: controller.textController,
                onChanged: (value) {
                  // controller.filteredList.value = controller.sections
                  //     .where((element) => element
                  //         .toString()
                  //         .toLowerCase()
                  //         .contains(value.toLowerCase()))
                  //     .toList();

                  // if (value.isEmpty || value.length == 0) {
                  //   controller.listVisible.value = false;
                  //   controller.filteredList.clear();
                  //   print("value is null");
                  // } else if (controller.filteredList.contains(value) &&
                  //     controller.filteredList.length == 1) {
                  //   controller.listVisible.value = false;
                  // } else {
                  //   controller.listVisible.value = true;
                  // }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        // controller.textController.clear();
                        // controller.filteredList.value = [];
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
            // Obx(() => controller.filteredList.isEmpty
            //     ? SizedBox()
            //     : ConstrainedBox(
            //         constraints: BoxConstraints(
            //           minWidth: double.infinity,
            //           maxHeight: controller.listVisible.value ? height : 0,
            //         ),
            //         child: ListView.separated(
            //           padding: EdgeInsets.zero,
            //           physics: const BouncingScrollPhysics(),
            //           shrinkWrap: true,
            //           itemCount: controller.filteredList.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               onTap: () {
            //                 controller.textController.text =
            //                     controller.filteredList[index];
            //                 controller.textController.selection =
            //                     TextSelection.fromPosition(TextPosition(
            //                         offset:
            //                             controller.textController.text.length));
            //                 controller.listVisible.value = false;
            //               },
            //               dense: true,
            //               contentPadding: EdgeInsets.zero,
            //               leading: Text(
            //                 controller.filteredList[index],
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .titleSmall!
            //                     .copyWith(fontWeight: FontWeight.bold),
            //               ),
            //             );
            //           },
            //           separatorBuilder: (context, index) {
            //             return const Divider(
            //               color: primaryColor,
            //               height: 2,
            //               // indent: 15,
            //               // endIndent: 15,
            //             );
            //           },
            //         ),
            //       ))
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
              // if (controller.sections.contains(value)) {
              // Storing the information for state persistency
              //   final box1 = await Hive.openBox(DBNames.info);
              //   box1.put(DBInfo.searchSection, value);

              //   final box2 = await Hive.openBox(DBNames.history);
              //   List list =
              //       box2.get(DBHistory.studentTimetable, defaultValue: []);
              //   if (list.length != 6) {
              //     Set result = list.toSet();
              //     result.add(value);
              //     box2.put(DBHistory.studentTimetable, result.toList());
              //     // await box2.close();
              //   }
              //   Get.toNamed(Routes.STUDENT_TIMETABLE, arguments: [value]);
              // } else {
              //   GetXUtilities.snackbar(
              //       title: 'Not Found!!',
              //       message: 'Enter Valid Section Name',
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