import 'package:cui_timetable/app/data/database/rooms_location.dart';
import 'package:cui_timetable/app/modules/location/views/widgets/location_widgets.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var roomsKeys = [];
  @override
  void onInit() {
    roomsKeys = roomsLocation.keys.toList();
    super.onInit();
    // authCache = await Hive.openBox(DBNames.authCache);
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return const Text("Unhandle cased yet");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var room in roomsLocation.keys) {
      if (room.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(room);
      }
    }
    return Container(
      padding: EdgeInsets.all(Constants.defaultPadding / 2),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return LocationDetailsTile(
              room: result,
              location: roomsLocation[result],
              dept: roomsLocation[result][0]);
        },
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search here';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          hintStyle: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.none,
            ),

            // gapPadding: 4,
          )),
    );
  }
}
