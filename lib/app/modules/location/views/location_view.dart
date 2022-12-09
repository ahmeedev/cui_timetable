import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/database/rooms_location.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Locations'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Get.toNamed('/settings');
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: roomsLocation.length,
        itemBuilder: (BuildContext context, int index) {
          final textTheme = Theme.of(context).textTheme;
          final cardHeight = Get.height * 0.12;
          return Container(
            height: cardHeight,
            child: Card(
              child: ListTile(
                title: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          roomsLocation[controller.roomsKeys[index]][0],
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Dept",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    kWidth,
                    Container(
                      width: 3,
                      height: cardHeight,
                      color: primaryColor,
                    ),
                    kWidth,
                    kWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Room:       ",
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            Text("  ${controller.roomsKeys[index]}"),
                          ],
                        ),
                        kHeight,
                        Row(
                          children: [
                            Text(
                              "Location: ",
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                                " ${roomsLocation[controller.roomsKeys[index]]}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ).paddingAll(Constants.defaultPadding),
              ),
            ),
          );
        },
      ),
    );
  }
}
