import 'package:cui_timetable/controllers/timetable/student_ui_controller.dart';
import 'package:cui_timetable/controllers/timetable/timetable_main_controller.dart';
import 'package:cui_timetable/views/timetable/student_timetable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentUI extends StatelessWidget {
  late final TextEditingController _textController;
  final timetableController = TimetableController();
  final controller = StudentUIController();

  StudentUI() {
    controller.fetchSections();
    print('done');
    var string = '';
    Future<void> test() async {
      final box = await Hive.openBox('info');
      var value = box.get("search_section").toString();
      if (value != "null") {
        string = value;
      }
    }

    test();
    _textController = TextEditingController(text: string);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(),
              const SizedBox(
                height: 20,
              ),
              _buildButton()
            ],
          ),
        ));
  }

// Build the textfield portion.
  Card _buildTextField() {
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
                controller: _textController,
                onChanged: (value) {
                  timetableController.filteredList.value = controller.sections
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        _textController.clear();
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
                ? SizedBox()
                : SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.separated(
                      itemCount: timetableController.filteredList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            _textController.text =
                                timetableController.filteredList[index];
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
              // if (startUpController.sections
              //     .contains(_textController.text.toString())) {
              /// Storing the information for state persistency
              // final box = await Hive.openBox('info');
              // box.put('search_section', _textController.text.toString());
              Get.to(StudentTimetable(), arguments: [_textController.text]);
              // } else {
              //   Get.snackbar(
              //       "Invalid Section", "Please! Enter the Valid Section",
              //       snackPosition: SnackPosition.BOTTOM,
              //       snackStyle: SnackStyle.GROUNDED);
              // }
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Find Now'),
            )),
      ),
    );
  }
}
