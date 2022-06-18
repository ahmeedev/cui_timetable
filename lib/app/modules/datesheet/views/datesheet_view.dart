import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/datesheet/views/widgets/student_ui.dart';
import 'package:cui_timetable/app/modules/datesheet/views/widgets/teacher_ui.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

import '../controllers/datesheet_controller.dart';

class DatesheetView extends GetView<DatesheetController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            buildAppBar(context),
            SliverFillRemaining(
              child: TabBarView(
                children: [StudentUI(), TeacherUI()],
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverAppBar buildAppBar(context) {
    return SliverAppBar(
        title: const Text('Datesheet'),
        centerTitle: true,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: Constants.defaultPadding),
        //     child: Icon(
        //       Icons.search,
        //     ),
        //   )
        // ],
        bottom: TabBar(
          indicatorPadding: EdgeInsets.all(Constants.defaultPadding / 3),
          indicatorWeight: 4,
          indicatorColor: shadowColor,
          tabs: [
            Tab(
                child: Text(
              'Student',
              style: Theme.of(context).textTheme.labelLarge,
            )),
            Tab(
                child: Text(
              'Teacher',
              style: Theme.of(context).textTheme.labelLarge,
            )),
          ],
        ));
  }
}
