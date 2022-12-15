import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_request_controller.dart';

class BookingRequestView extends GetView<BookingRequestController> {
  const BookingRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Request(s)'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                minVerticalPadding: 5.0,
                title: Padding(
                  padding: EdgeInsets.only(top: Constants.defaultPadding / 2),
                  child: const Text(
                      "as@gmail.com register their name as CS Mr. Ahmad Shaf"),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: Constants.defaultPadding / 2),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Cancel")),
                      kWidth,
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text("Approved")
                              .paddingAll(Constants.defaultPadding / 2))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
