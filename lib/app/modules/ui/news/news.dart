import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding)
            .copyWith(top: Constants.defaultPadding + 4),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return buildNews(context,
                title: list[index]['title'],
                description: list[index]['description'],
                expanded: index == 0 ? true : false);
          },
        ),
      ),
    );
  }

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
              childrenPadding: EdgeInsets.fromLTRB(Constants.defaultPadding * 3,
                  0, Constants.defaultPadding, Constants.defaultPadding + 15),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
}
