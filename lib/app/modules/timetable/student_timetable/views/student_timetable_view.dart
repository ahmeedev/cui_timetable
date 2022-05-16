import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_timetable_controller.dart';

class StudentTimetableView extends GetView<StudentTimetableController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudentTimetableView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StudentTimetableView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
