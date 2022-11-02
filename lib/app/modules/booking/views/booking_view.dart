import 'package:cui_timetable/app/modules/booking/controllers/booking_controller.dart';
import 'package:cui_timetable/app/modules/booking/views/make_booking.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import 'booking_log.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

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

                  BookingWidget(),
                  BookingLog(),
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
        title: const Text('Booking'),
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
                'Make Booking',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )),
            Tab(
                child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Booking Log',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )),
          ],
        ));
  }
}
