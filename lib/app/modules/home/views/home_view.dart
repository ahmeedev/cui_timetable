import 'package:flutter/material.dart';

import 'package:cui_timetable/app/modules/home/views/widgets/home_drawer.dart';
import 'package:cui_timetable/app/modules/home/views/widgets/home_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBody: true,

        // extendBodyBehindAppBar: true,
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Container(
            color: scaffoldColor,
            child: Column(
              children: const [Header(), ButtonList()],
            ),
          ),
        ),
        body: Stack(
          // fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,

          children: const [
            CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                HomeAppBar(),
                HomeBody(),
                // const HomeBottomWidget(),
              ],
            ),
            HomeOverlay()
          ],
        ));
  }
}
