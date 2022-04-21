import 'package:cui_timetable/controllers/timetable/student_ui_controller.dart';
import 'package:cui_timetable/controllers/timetable/timetable_main_controller.dart';
import 'package:cui_timetable/views/timetable/student_timetable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentUI extends StatelessWidget {
  final timetableController = TimetableController();
  final controller = Get.put(StudentUIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(context),
              const SizedBox(
                height: 20,
              ),
              _buildButton()
            ],
          ),
        ));
  }

// Build the textfield portion.
  Card _buildTextField(context) {
    var height = MediaQuery.of(context).size.height / 4;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text('Section'),
            const SizedBox(
              height: 10,
            ),
            // TypeAheadField(
            //   textFieldConfiguration:
            //       TextFieldConfiguration(
            //           controller: _textController,
            //           decoration: InputDecoration(
            //             suffixIcon: IconButton(
            //                 onPressed: () {
            //                   _textController.clear();
            //                 },
            //                 icon: const Icon(
            //                   Icons.cancel,
            //                   color: Colors.blue,
            //                 )),
            //             fillColor: Colors.grey.shade200,
            //             filled: true,
            //             border: OutlineInputBorder(
            //                 borderRadius:
            //                     BorderRadius.circular(10.0),
            //                 borderSide: BorderSide(
            //                     color:
            //                         Colors.grey.shade200)),
            //           )),
            //   suggestionsCallback: (pattern) =>
            //       startUpController.sections.where(
            //           (element) => element
            //               .toString()
            //               .toLowerCase()
            //               .contains(pattern.toLowerCase())),
            //   itemBuilder: (_, suggestion) {
            //     return ListTile(
            //         title: Text(suggestion.toString()));
            //   },
            //   onSuggestionSelected: (suggestion) {
            //     _textController.text =
            //         suggestion.toString();
            //   },
            // ),
            TextFormField(
                controller: controller.textController,
                onChanged: (value) {
                  timetableController.filteredList.value = controller.sections
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                  if (timetableController.filteredList.contains(value) &&
                      timetableController.filteredList.length == 1) {
                    timetableController.listVisible.value = false;
                  } else {
                    timetableController.listVisible.value = true;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.textController.clear();
                        timetableController.filteredList.value = [];
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.blue,
                      )),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                )),

            // const SizedBox(
            //   height: 10,
            // ),
            Obx(() => timetableController.filteredList.isEmpty
                ? const SizedBox()
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      maxHeight:
                          timetableController.listVisible.value ? height : 0,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: timetableController.filteredList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            controller.textController.text =
                                timetableController.filteredList[index];
                            controller.textController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                        controller.textController.text.length));
                            timetableController.listVisible.value = false;
                          },
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading:
                              Text(timetableController.filteredList[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
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
  Padding _buildButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: IntrinsicWidth(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            onPressed: () async {
              if (timetableController.filteredList
                  .contains(controller.textController.text.toString())) {
                // Storing the information for state persistency
                final box = await Hive.openBox('info');
                box.put('search_section',
                    controller.textController.text.toString());

                Get.to(StudentTimetable(),
                    transition: Transition.cupertino,
                    arguments: [controller.textController.text]);
              } else {
                Get.snackbar(
                    "Invalid Section", "Please! Enter the Valid Section",
                    snackPosition: SnackPosition.BOTTOM,
                    snackStyle: SnackStyle.GROUNDED);
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Find Now'),
            )),
      ),
    );
  }
}
