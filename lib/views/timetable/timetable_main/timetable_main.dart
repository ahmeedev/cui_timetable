import 'package:cui_timetable/controllers/startup/startup_controller.dart';
import 'package:cui_timetable/controllers/timetable/timetable_main_controller.dart';
import 'package:cui_timetable/views/timetable/student_timetable.dart';
import 'package:cui_timetable/views/timetable/timetable_main/student_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: use_key_in_widget_constructors
class Timetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            buildAppBar(),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  StudentUI(),

                  // main container

                  const Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverAppBar buildAppBar() {
    return const SliverAppBar(
        title: Text('Timetable'),
        centerTitle: true,
        actions: [Icon(Icons.search)],
        bottom: TabBar(
          indicatorColor: Colors.red,
          tabs: [
            Tab(child: Text('Student')),
            Tab(child: Text('Teacher')),
            Tab(child: Text('Compare')),
          ],
        ));
  }
}
