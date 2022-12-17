import 'package:cui_timetable/app/data/database/notification_topics.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/utilities/notifications/cloud_notifications.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  var normalStyle = const TextStyle(
      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w900);
  var selectedStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900);

  var segmentedControlGroupValue = 0.obs;
  Map<int, Widget>? myTabs;
  var styles = [].obs;

  @override
  void onInit() {
    styles.add(selectedStyle);
    styles.add(normalStyle);
    styles.add(normalStyle);
    myTabs = <int, Widget>{
      0: Obx(() => Text("Students", style: styles[0])),
      1: Obx(() => Text("Teachers", style: styles[1])),
      2: Obx(() => Text("Both", style: styles[2])),
    };
    super.onInit();
  }

  changeSegmentState(value) {
    segmentedControlGroupValue.value = int.parse(value.toString());

    for (var i = 0; i < styles.length; i++) {
      styles[i] = normalStyle;
    }
    styles[segmentedControlGroupValue.value] = selectedStyle;
  }

  makeAnnouncement() async {
    String respectedTopic = everyoneTopic;

    if (segmentedControlGroupValue.value == 0) {
      respectedTopic = studentTopic;
    } else if (segmentedControlGroupValue.value == 1) {
      respectedTopic = teacherTopic;
    } else if (segmentedControlGroupValue.value == 2) {
      respectedTopic = everyoneTopic;
    }

    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty) {
      await sendCloudNotification(
          topic: respectedTopic,
          title: titleController.text.trim(),
          description: descriptionController.text.trim());

      GetXUtilities.snackbar(
          title: "Announc!",
          message: "Your message has been deliverd to the $respectedTopic",
          gradient: successGradient);
    } else {
      GetXUtilities.snackbar(
          title: "Error!",
          message: "Title and descriptions never be empty",
          gradient: errorGradient);
    }
  }
}
