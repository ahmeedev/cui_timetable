import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

Card buildNews(context,
    {required String title,
    required String description,
    required bool expanded}) {
  return Card(
      color: widgetColor,
      elevation: defaultElevation,
      shadowColor: shadowColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            initiallyExpanded: expanded,
            // backgroundColor: widgetColor,
            iconColor: primaryColor,

            // trailing: const Icon(Icons.motion_photos_on_rounded),

            // tilePadding: EdgeInsets.all(0),
            childrenPadding: const EdgeInsets.fromLTRB(
                defaultPadding, 0, defaultPadding, defaultPadding + 15),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                textAlign: TextAlign.justify,
                textDirection: TextDirection.ltr,
              )
            ]),
      ));
}
