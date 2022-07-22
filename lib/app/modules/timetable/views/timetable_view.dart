import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/timetable_controller.dart';
import 'widgets/comparison_ui_view.dart';
import 'widgets/student_ui_view.dart';
import 'widgets/teacher_ui_view.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

// ignore: use_key_in_widget_constructors
class TimetableView extends GetView<TimetableController> {
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
            const SliverFillRemaining(
              child: TabBarView(
                children: [
                  StudentUIView(),
                  TeacherUIView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverAppBar buildAppBar(context) {
    return SliverAppBar(
        title: const Text('Timetable'),
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
            // Tab(
            //     child: Text(
            //   'Compare',
            //   style: Theme.of(context).textTheme.labelLarge,
            // )),
          ],
        ));
  }
}
