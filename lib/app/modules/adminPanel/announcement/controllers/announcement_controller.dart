import 'package:cui_timetable/app/data/database/notification_topics.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/utilities/notifications/cloud_notifications.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController {
  final studentTitleController = TextEditingController();
  final studentDescriptionController = TextEditingController();

  final teacherTitleController = TextEditingController();
  final teacherDescriptionController = TextEditingController();

  makeAnnouncement({
    bool isTeacher = false,
  }) async {
    if (isTeacher) {
      if (teacherTitleController.text.trim().isNotEmpty &&
          teacherDescriptionController.text.trim().isNotEmpty) {
        await sendCloudNotification(
            topic: teacherTopic,
            title: teacherTitleController.text.trim(),
            description: teacherDescriptionController.text.trim());
      } else {
        GetXUtilities.snackbar(
            title: "Error!",
            message: "Title and descriptions never be empty",
            gradient: errorGradient);
      }
      GetXUtilities.snackbar(
          title: "Announc!",
          message: "Your message has been deliverd to the teachers",
          gradient: successGradient);
    } else {
      if (studentTitleController.text.trim().isNotEmpty &&
          studentDescriptionController.text.trim().isNotEmpty) {
        await sendCloudNotification(
            topic: studentTopic,
            title: studentTitleController.text.trim(),
            description: studentDescriptionController.text.trim());

        GetXUtilities.snackbar(
            title: "Announc!",
            message: "Your message has been deliverd to the students",
            gradient: successGradient);
      } else {
        GetXUtilities.snackbar(
            title: "Error!",
            message: "Title and descriptions never be empty",
            gradient: errorGradient);
      }
    }
  }
}
