import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import '../controllers/announcement_controller.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Announcement")),
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
                    Row(
                      children: [
                        Text(
                          "To",
                          style: textTheme.labelLarge!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        kWidth,
                        Expanded(
                          child: Obx(() => CupertinoSlidingSegmentedControl(
                                backgroundColor: selectionColor,
                                thumbColor: primaryColor,
                                groupValue:
                                    controller.segmentedControlGroupValue.value,
                                padding: EdgeInsets.all(
                                    Constants.defaultPadding / 2),
                                children: controller.myTabs!,
                                onValueChanged: (value) {
                                  controller.changeSegmentState(value);
                                },
                              )),
                        ),
                      ],
                    ),
                    kHeight,
                    kHeight,
                    TextFormField(
                        controller: controller.titleController,
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
                        controller: controller.descriptionController,
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
