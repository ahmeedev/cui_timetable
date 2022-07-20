import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'widgets/student_ui.dart';
import 'widgets/teacher_ui.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

import '../controllers/datesheet_controller.dart';

class DatesheetView extends GetView<DatesheetController> {
  const DatesheetView({Key? key}) : super(key: key);

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
