import 'package:cui_timetable/app/modules/reports/views/reported_view.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
 const ReportsView({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: onScaffoldColor,
      appBar: AppBar(
        title: const Text('Report/Feedback'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: controller.isReports == false
          ? const Center(
              child: Text(
                'No Reports/Feedbacks available',
                style: TextStyle(fontSize: 20),
              ),
            )
          :const ReportedView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.NEW_REPORT);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
