// ignore_for_file: prefer_const_constructors

import 'package:cui_timetable/app/modules/remainder/views/widgets/student_ui.dart';
import 'package:cui_timetable/app/modules/remainder/views/widgets/teacher_ui.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/remainder_controller.dart';

class RemainderView extends GetView<RemainderController> {
  const RemainderView({Key? key}) : super(key: key);

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
        title: const Text('Remainder'),
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
