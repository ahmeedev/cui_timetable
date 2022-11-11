import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../../freerooms/models/freerooms_model.dart';
import '../../../../freerooms/views/widgets/freerooms_widgets.dart';

class BookingFreerooms extends StatelessWidget {
  BookingFreerooms({Key? key, required this.classes}) : super(key: key);
  final List<String> dept = ['A', 'B', 'C', 'W'];
  final List<FreeroomsSubClass> classes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: Constants.defaultPadding),
      itemCount: dept.length,
      itemBuilder: (BuildContext context, int index) {
        return FreeroomsDepartmentWiseExpensionTile(
          department: dept[index],
          totalClasses: classes[index].totalClasses,
          availableClasses: classes[index].classes,
          initialExpanded: index == 0 ? true : false,
          isBookingCard: true,
        );
      },
    );
  }
}
