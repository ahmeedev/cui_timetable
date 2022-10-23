import '../../controllers/teacher_ui_controller.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherUI extends GetView<RemainderTeacherUIController> {
  const TeacherUI({Key? key}) : super(key: key);

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
                controller: controller.textController,
                onChanged: (value) {
                  controller.filteredList.value = controller.teachers
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
              // final value = controller.textController.text.toString();
              // if (controller.teachers.contains(value)) {
              //   // Storing the information for state persistency
              //   final box1 = await Hive.openBox(DBNames.info);
              //   box1.put(DBInfo.datesheetSearchTeacher, value);

              //   Get.toNamed(Routes.TEACHER_DATESHEET, arguments: [value]);
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
                child: Text('Set Remainder',
                    style: Theme.of(context).textTheme.labelLarge
                    // .copyWith(fontSize: 16),
                    ),
              ),
            )),
      ),
    );
  }
}
