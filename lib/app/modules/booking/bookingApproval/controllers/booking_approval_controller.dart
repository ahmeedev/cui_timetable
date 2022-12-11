import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';

class BookingApprovalController extends GetxController {
  var teachers = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  var dialogHistoryList = [].obs;

  @override
  Future<void> onInit() async {
    await fetchTeachers();
    var string = '';

    // final box = await Hive.openBox(DBNames.info);
    // try {
    //   String value = box.get(DBTimetableCache.teacherName, defaultValue: '');
    //   if (value.isNotEmpty) {
    //     string = value.toString();
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());
    // }

    textController.text = string;

    super.onInit();
  }

  postApproval({required String name}) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection('approvals')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      "email": FirebaseAuth.instance.currentUser!.email,
      'approved': false,
    });

    GetXUtilities.snackbar(
        title: "Sent",
        message: "Your approval is sent to the admin",
        gradient: successGradient);
  }

  Future<void> fetchTeachers() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.teachers);
    teachers = list ?? [];
  }
}
