import 'package:cui_timetable/app/modules/booking/bookingDetails/controllers/booking_details_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/utilities/time/cloud_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              FutureBuilder<DateTime>(
                  future: currentTime(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: SfDateRangePicker(
                          backgroundColor: widgetColor,
                          minDate: snapshot.data,
                          maxDate: snapshot.data!.add(const Duration(days: 14)),
                          selectableDayPredicate: (date) {
                            final bookingDay =
                                Get.find<BookingDetailsController>().bookingDay;

                            if (date.weekday == bookingDay) {
                              // logger.i('yes');
                              return true;
                            } else {
                              return false;
                            }

                            // If the user select the date on weekended
                          },
                        ),
                      );
                    }

                    return const Expanded(
                      child: SpinKitFadingCube(color: primaryColor, size: 30.0),
                    );
                  }),
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
