import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../home/views/widgets/home_widgets.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widgetsPlaceholderHeight = height * 0.52 + 15;
    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder(
      stream: controller.getNewsStream(),
      // initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return const Text('Connect to the Internet to fetch News...');
          }
          print(snapshot.data);
          return SizedBox(
            width: width,
            height: widgetsPlaceholderHeight,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildNews(context,
                    title: snapshot.data[index]['title'],
                    description: snapshot.data[index]['description'],
                    expanded: index == 0 ? true : false),
                itemCount: snapshot.data.length),
          );
        }
        return Text(
          'Fetching news...',
          textAlign: TextAlign.center,
          style: textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.w900, color: Colors.black),
        );
      },
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
