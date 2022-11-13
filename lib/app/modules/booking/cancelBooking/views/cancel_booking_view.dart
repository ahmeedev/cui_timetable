import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/cancel_booking_controller.dart';
import 'widgets/cancel_booking_widgets.dart';

class CancelBookingView extends GetView<CancelBookingController> {
  const CancelBookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Booking'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style:
                      theme.textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(() => Theme(
                    data: theme.copyWith(
                        splashColor: selectionColor,
                        highlightColor: selectionColor,
                        colorScheme: const ColorScheme.light(
                          primary: errorColor1,
                        )),
                    child: Stepper(
                        physics: const BouncingScrollPhysics(),
                        currentStep: controller.currentStep.value,
                        // onStepTapped: (index) {
                        //   controller.currentStep.value = index;
                        // },
                        onStepContinue: () {
                          if (controller.currentStep.value == 1) {
                            Get.back();
                          } else if (controller.currentStep.value < 1) {
                            controller.currentStep.value++;
                            // if (controller.currentStep.value == 1) {
                            // controller.book(
                            //   section: controller.bookingFor,
                            //   slot: controller.bookingSlot,
                            //   room: controller.bookingRoom.value,
                            // );
                            // }
                          }
                        },
                        onStepCancel: () {
                          // if (controller.currentStep.value > 0) {
                          //   if (!controller.isBookingSuccessful.value) {
                          //     controller.currentStep.value--;
                          //   } else {
                          //     GetXUtilities.snackbar(
                          //         duration: 3,
                          //         title: 'Room Booked!',
                          //         message:
                          //             'Room is already booked, to unbook go to BOOKING LOG',
                          //         gradient: primaryGradient);
                          //   }
                          // }
                        },
                        steps: [
                          Step(
                              isActive: controller.currentStep.value >= 0,
                              title: const Text("Cancel Booking"),
                              content:
                                  const CancelBookingDetailsStepperWidget()),
                          Step(
                              isActive: controller.currentStep.value >= 1,
                              title: const Text("Finalize Booking"),
                              content: const Card(
                                child: Text("CHild 2"),
                              )),
                        ]),
                  ));
            }
            return const Center(
              child: SpinKitFadingCube(
                color: primaryColor,
                size: 30.0,
              ),
            );
          }),
    );
  }
}
