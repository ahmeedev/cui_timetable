import 'package:flutter/material.dart';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

// Flutter imports:

// Project imports:

Card buildNews(context,
    {required String title,
    required String description,
    required bool expanded}) {
  return Card(
      color: widgetColor,
      elevation: Constants.defaultElevation,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
        child: ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            initiallyExpanded: expanded,
            backgroundColor: widgetColor,
            iconColor: primaryColor,

            // trailing: const Icon(Icons.motion_photos_on_rounded),

            tilePadding:
                EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
            childrenPadding: EdgeInsets.fromLTRB(Constants.defaultPadding, 0,
                Constants.defaultPadding, Constants.defaultPadding + 15),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
                textDirection: TextDirection.ltr,
              )
            ]),
      ));
}
