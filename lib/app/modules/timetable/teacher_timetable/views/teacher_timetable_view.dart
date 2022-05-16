import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_timetable_controller.dart';

class TeacherTimetableView extends GetView<TeacherTimetableController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TeacherTimetableView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TeacherTimetableView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
