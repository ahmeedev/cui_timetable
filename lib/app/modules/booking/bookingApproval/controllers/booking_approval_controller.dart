import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/data/database/notification_topics.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';
import '../../../../utilities/notifications/cloud_notifications.dart';

class BookingApprovalController extends GetxController {
  final isPostApproval = Get.arguments['isPostApproval'];
  final name = Get.arguments['name'];
  var isPosted = false.obs;
  var teachers = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;

  @override
  Future<void> onInit() async {
    await fetchTeachers();
    isPosted.value = isPostApproval;
    textController.text = name;
    super.onInit();
  }

  postApproval({required String name}) async {
    if (teachers.contains(textController.text)) {
      final db = FirebaseFirestore.instance;
      await db
          .collection('approvals')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': textController.text.toString(),
        "email": FirebaseAuth.instance.currentUser!.email,
        'approved': false,
      });
      sendCloudNotification(
        topic:
            adminTopic, //? send the notification to the admin for the approval.
        title: "New Request!",
        description:
            "A new request has been made. Make sure their name is correct.",

        toAdmin: true,
      );
      isPosted.value = true;
      GetXUtilities.snackbar(
          title: "Queued!",
          message: "Your approval is queued successfully.",
          gradient: successGradient);
    } else {
      GetXUtilities.snackbar(
          title: "Error!",
          message: "Select your name from the list.",
          gradient: errorGradient);
    }
  }

  Future<void> fetchTeachers() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.teachers);
    teachers = list ?? [];
  }
}
