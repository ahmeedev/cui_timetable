import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';
import '../../controllers/announcement_controller.dart';

class StudentAnnouncement extends GetView<AnnouncementController> {
  const StudentAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: se,
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: widgetColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    kHeight,
                    TextFormField(
                        controller: controller.studentTitleController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        // controller: controller.textController,

                        decoration: InputDecoration(
                          fillColor: selectionColor,
                          filled: true,
                          hintText: "Enter the title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Constants.defaultRadius),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                        )),
                    kHeight,
                    TextFormField(
                        controller: controller.studentDescriptionController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        // controller: controller.textController,
                        maxLength: 150,
                        maxLines: 10,
                        decoration: InputDecoration(
                          fillColor: selectionColor,
                          filled: true,
                          hintText: "Enter the Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Constants.defaultRadius),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                        )),
                  ],
                ).paddingAll(Constants.defaultPadding),
              ),
              kHeight,
              kHeight,
              ElevatedButton(
                  onPressed: () {
                    controller.makeAnnouncement();
                  },
                  child: const Text("Make Announcement")
                      .paddingAll(Constants.defaultPadding * 2))
            ],
          ),
        ));
  }
}

class TeacherAnnouncement extends GetView<AnnouncementController> {
  const TeacherAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: se,
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: widgetColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    kHeight,
                    TextFormField(
                        controller: controller.teacherTitleController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        // controller: controller.textController,

                        decoration: InputDecoration(
                          fillColor: selectionColor,
                          filled: true,
                          hintText: "Enter the title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Constants.defaultRadius),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                        )),
                    kHeight,
                    TextFormField(
                        controller: controller.teacherDescriptionController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        // controller: controller.textController,
                        maxLength: 150,
                        maxLines: 10,
                        decoration: InputDecoration(
                          fillColor: selectionColor,
                          filled: true,
                          hintText: "Enter the Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Constants.defaultRadius),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                        )),
                  ],
                ).paddingAll(Constants.defaultPadding),
              ),
              kHeight,
              kHeight,
              ElevatedButton(
                  onPressed: () {
                    controller.makeAnnouncement(isTeacher: true);
                  },
                  child: const Text("Make Announcement")
                      .paddingAll(Constants.defaultPadding * 2))
            ],
          ),
        ));
  }
}
