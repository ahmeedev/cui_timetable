import 'package:cui_timetable/app/modules/location/views/widgets/location_widgets.dart';
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
              showSearch(
                  context: context,
                  // delegate to customize the search bar

                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.defaultPadding / 2),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: roomsLocation.length,
          itemBuilder: (BuildContext context, int index) {
            return LocationDetailsTile(
              room: controller.roomsKeys[index],
              location: roomsLocation[controller.roomsKeys[index]],
              dept: roomsLocation[controller.roomsKeys[index]][0],
            );
          },
        ),
      ),
    );
  }
}
