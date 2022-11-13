import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_details_controller.dart';
import 'widgets/booking_details_widgets.dart';

class BookingDetailsView extends GetView<BookingDetailsController> {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
      ),
      body: Obx(() => Theme(
            data: theme.copyWith(
                splashColor: selectionColor,
                highlightColor: selectionColor,
                colorScheme: const ColorScheme.light(
                  primary: primaryColor,
                )),
            child: Stepper(
                physics: const BouncingScrollPhysics(),
                currentStep: controller.currentStep.value,
                // onStepTapped: (index) {
                //   controller.currentStep.value = index;
                // },
                onStepContinue: () {
                  if (controller.currentStep.value == 2) {
                    Get.back();
                  } else if (controller.currentStep.value < 2) {
                    controller.currentStep.value++;
                    if (controller.currentStep.value == 1) {
                      controller.book(
                        section: controller.bookingFor,
                        slot: controller.bookingSlot,
                        room: controller.bookingRoom.value,
                      );
                    }
                  }
                },
                onStepCancel: () {
                  if (controller.currentStep.value > 0) {
                    if (!controller.isBookingSuccessful.value) {
                      controller.currentStep.value--;
                    } else {
                      GetXUtilities.snackbar(
                          duration: 3,
                          title: 'Room Booked!',
                          message:
                              'Booking in progress, to unbook go to BOOKING LOG',
                          gradient: primaryGradient);
                    }
                  }
                },
                steps: [
                  Step(
                    isActive: controller.currentStep.value >= 0,
                    title: const Text("Booking Details"),
                    content: const BookingDetailsStepperWidget(),
                  ),
                  Step(
                      isActive: controller.currentStep.value >= 1,
                      title: const Text("Finalize Booking"),
                      content: const BookingFinalizeStepperWidget()),
                  Step(
                      isActive: controller.currentStep.value >= 2,
                      title: const Text("Status"),
                      content: const BookingStatusStepperWidget()),
                ]),
          )),
    );
  }
}
