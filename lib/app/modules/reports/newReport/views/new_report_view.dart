import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_constants.dart';
import '../controllers/new_report_controller.dart';

class NewReportView extends GetView<NewReportController> {
  const NewReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onScaffoldColor,
      appBar: AppBar(
        title: const Text('Add New Report'),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              createInputField(context),
              SizedBox(
                height: Constants.defaultPadding,
              ),
              createButton(context),
            ],
          )),
    );
  }

  Padding createButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: IntrinsicWidth(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
              onPressed: () {
                if (controller.titleControler.text.isEmpty) {
                  GetXUtilities.snackbar(
                      title: "Title can't be empty ",
                      message: 'Please enter a valid title',
                      gradient: errorGradient);
                } else if (controller.descripControler.text.isEmpty) {
                  GetXUtilities.snackbar(
                      title: "Description can't be empty ",
                      message: 'Please fill the description field ',
                      gradient: errorGradient);
                } else {
                  controller.uploadData(controller.titleControler.text,
                      controller.descripControler.text, DateTime.now());
                }
                // controller.titleControler.text.isEmpty ||
                //         controller.descripControler.text.isEmpty
                //     ? GetXUtilities.snackbar(
                //         title: 'Empty fields found',
                //         message: 'Both Fields must be filled',
                //         gradient: primaryGradient)
                //     : controller.uploadData();
              },
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Text('Submit',
                      style: Theme.of(context).textTheme.labelLarge
                      // .copyWith(fontSize: 16),
                      ),
                ),
              )),
        ));
  }

  Card createInputField(BuildContext context) {
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
              children: [
                Text(
                  'Title',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            TextFormField(
              controller: controller.titleControler,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Title can't be empty";
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Enter title here'),
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            Row(
              children: [
                Text(
                  'Description',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            SizedBox(
              height: Constants.defaultPadding,
            ),
            TextFormField(
              controller: controller.descripControler,
              maxLength: 80,
              maxLines: 7,
              decoration:
                  const InputDecoration(hintText: 'Enter Description here'),
            ),
          ],
        ),
      ),
    );
  }
}
