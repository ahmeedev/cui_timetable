import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

import '../controllers/comparison_controller.dart';
import 'widgets/sect_sect_widget.dart';
import 'widgets/teac_sect_widget.dart';

class ComparisonView extends GetView<ComparisonController> {
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final keys = ['10000', '1000', '100', '10', '1'];

  ComparisonView({Key? key}) : super(key: key);

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
                  // StudentUIView(),
                  // TeacherUIView(),

                  SectSectWidget(),
                  TeacSectWidget(),
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
        title: const Text('Comparision'),
        centerTitle: true,
        bottom: TabBar(
          indicatorPadding: EdgeInsets.all(Constants.defaultPadding / 3),
          indicatorWeight: 4,
          indicatorColor: shadowColor,
          tabs: [
            Tab(
                child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Section-Section',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )),
            Tab(
                child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Teacher-Section',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )),
          ],
        ));
  }
}
