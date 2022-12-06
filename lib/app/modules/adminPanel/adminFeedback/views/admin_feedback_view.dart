import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/views/repoted_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_feedback_controller.dart';

class AdminFeedbackView extends GetView<AdminFeedbackController> {
  const AdminFeedbackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes/Feedbacks'),
        centerTitle: true,
      ),
      body: const AdminRepotedView(),
    );
  }
}
