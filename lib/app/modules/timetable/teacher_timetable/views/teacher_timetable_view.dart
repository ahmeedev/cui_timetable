import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_timetable_controller.dart';

class TeacherTimetableView extends GetView<TeacherTimetableController> {
  const TeacherTimetableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeacherTimetableView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeacherTimetableView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
