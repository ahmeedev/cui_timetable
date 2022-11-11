import 'package:cui_timetable/app/modules/booking/bookingDetails/controllers/booking_details_controller.dart';
import 'package:cui_timetable/app/modules/booking/bookingRoom/views/widgets/booking_rooms_widgets.dart';
import 'package:cui_timetable/app/modules/freerooms/controllers/freerooms_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../controllers/booking_room_controller.dart';

class BookingRoomView extends GetView<BookingRoomController> {
  const BookingRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Room'),
          centerTitle: true,
          bottom: TabBar(
              indicatorPadding: EdgeInsets.all(Constants.defaultPadding / 3),
              indicatorWeight: 4,
              indicatorColor: shadowColor,
              tabs: [
                Tab(
                    child: Text(
                  'Rooms',
                  style: Theme.of(context).textTheme.labelLarge,
                )),
                Tab(
                    child: Text(
                  'Labs',
                  style: Theme.of(context).textTheme.labelLarge,
                )),
              ]),
        ),
        body: TabBarView(
          children: [
            BookingFreerooms(
                classes: Get.find<FreeroomsController>()
                    .freerooms[
                        Get.find<BookingDetailsController>().bookingSlot - 1]
                    .classes),
            BookingFreeLabs(
              labs: Get.find<FreeroomsController>()
                  .freerooms[
                      Get.find<BookingDetailsController>().bookingSlot - 1]
                  .labs,
            ),
          ],
        ),
      ),
    );
  }
}
