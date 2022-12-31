import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/booking_date_controller.dart';

class BookingDateView extends GetView<BookingDateController> {
  const BookingDateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingDateView'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SfDateRangePicker(
                  backgroundColor: widgetColor,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Select")
                      .paddingAll(Constants.defaultPadding * 2))
            ],
          )),
    );
  }
}
