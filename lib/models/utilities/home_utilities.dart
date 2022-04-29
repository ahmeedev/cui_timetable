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
              )
            ]),
      ));
}
