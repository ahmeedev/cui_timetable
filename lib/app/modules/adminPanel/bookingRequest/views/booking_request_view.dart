import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/booking_request_controller.dart';

class BookingRequestView extends GetView<BookingRequestController> {
  const BookingRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking Request(s)'),
          centerTitle: true,
        ),

        // body: ElevatedButton(
        //   child: const Text("preseed me"),
        //   onPressed: () {
        //     controller.getApprovalRequestes();
        //   },
        // ),
        body: Container(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: Obx(() => controller.loading.value
                ? const SpinKitFadingCube(
                    color: primaryColor,
                    size: 30.0,
                  )
                : controller.requestes.isEmpty
                    ? Center(
                        child: Text(
                        "No Request(s) yet found",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.requestes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Card(
                                child: ListTile(
                                  minVerticalPadding: 5.0,
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        top: Constants.defaultPadding / 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Email:     ",
                                                style: theme
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(controller
                                                  .requestes[index].email),
                                            ],
                                          ),
                                        ),
                                        kHeight,
                                        Row(
                                          children: [
                                            Text(
                                              "Name:    ",
                                              style: theme
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                controller
                                                    .requestes[index].name,
                                                style: theme
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                  color: successColor,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        kHeight,
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(
                                        top: Constants.defaultPadding / 2),
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.revokeBooking(
                                                  id: controller
                                                      .requestes[index].id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: errorColor1,
                                            ),
                                            child: const Text("Revoke")),
                                        kWidth,
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.approveBooking(
                                                  id: controller
                                                      .requestes[index].id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: successColor,
                                            ),
                                            child: const Text("Approved")
                                                .paddingAll(
                                                    Constants.defaultPadding /
                                                        2))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              controller.requestes[index].approved
                                  ? Positioned(
                                      right: 4,
                                      top: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                Constants.defaultRadius),
                                            topRight: Radius.circular(
                                                Constants.defaultRadius),
                                          ),
                                        ),
                                        child: Text(
                                          "Approved",
                                          style: theme.textTheme.labelLarge!
                                              .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ).paddingAll(Constants.defaultPadding),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ))));
  }
}
