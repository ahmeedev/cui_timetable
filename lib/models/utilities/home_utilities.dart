import 'package:cui_timetable/style.dart';
import 'package:flutter/material.dart';

Card buildNews(context, {required String title, required String description}) {
  return Card(
      elevation: defaultElevation,
      color: widgetColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            // backgroundColor: widgetColor,
            iconColor: primaryColor,
            trailing: Icon(Icons.motion_photos_on_rounded),

            // tilePadding: EdgeInsets.all(0),

            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            children: [
              ListTile(
                  // horizontalTitleGap: 8,
                  // minVerticalPadding: defaultPadding + 4,
                  subtitle: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textAlign: TextAlign.justify,
                ),
              ))
            ]),
      ));
}
