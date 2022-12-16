import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../controllers/announcement_controller.dart';
import 'widgets/announcement_widgets.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({Key? key}) : super(key: key);
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
            const SliverFillRemaining(
              child: TabBarView(
                children: [
                  StudentAnnouncement(),
                  TeacherAnnouncement(),
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
        title: const Text('Announcement'),
        centerTitle: true,
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
