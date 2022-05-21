import 'package:avatar_glow/avatar_glow.dart';
import 'package:cui_timetable/app/modules/timetable/controllers/timetable_controller.dart';
import 'package:cui_timetable/app/modules/timetable/views/student_ui_view.dart';
import 'package:cui_timetable/app/modules/timetable/views/teacher_ui_view.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class TimetableView extends GetView<TimetableController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            buildAppBar(context),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  const StudentUIView(),
                  const TeacherUIView(),

                  // main container
                  AvatarGlow(
                    endRadius: 190.0,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    glowColor: primaryColor,
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        )),
                  ),
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
        //     padding: EdgeInsets.only(right: defaultPadding),
        //     child: Icon(
        //       Icons.search,
        //     ),
        //   )
        // ],
        bottom: TabBar(
          indicatorPadding: const EdgeInsets.all(defaultPadding / 3),
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
            Tab(
                child: Text(
              'Compare',
              style: Theme.of(context).textTheme.labelLarge,
            )),
          ],
        ));
  }
}
