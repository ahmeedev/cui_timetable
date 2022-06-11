import 'package:cui_timetable/app/modules/portals/views/widgets/portal_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/portals_controller.dart';

class PortalsView extends GetView<PortalsController> {
  const PortalsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
// physics: const NeverScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverFillRemaining(
            // hasScrollBody: true,
            child: TabBarView(
              children: [StudentPortal(), TeacherPortal()],
            ),
          )
        ],
      ),
    );
  }

  _buildAppBar(context) {
    return SliverAppBar(
        title: const Text('CUI Portal'),
        centerTitle: true,
        pinned: true,
        bottom: TabBar(
          indicatorPadding: EdgeInsets.all(Constants.defaultPadding / 3),
          indicatorWeight: 4,
          indicatorColor: shadowColor,
          tabs: [
            Tab(
                child: Text(
              'Students',
              style: Theme.of(context).textTheme.labelLarge,
            )),
            Tab(
                child: Text(
              'Teachers',
              style: Theme.of(context).textTheme.labelLarge,
            )),
          ],
        ));
  }
}
