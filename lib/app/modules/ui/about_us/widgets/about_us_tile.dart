import 'package:flutter/material.dart';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

class AboutUsTile extends StatelessWidget {
  final String pic;
  final String name;
  final String subName;
  final String position;
  final String description;
  const AboutUsTile(
      {Key? key,
      required this.pic,
      required this.name,
      this.subName = '',
      required this.position,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.defaultPadding / 2),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Card(
                color: widgetColor,
                elevation: Constants.defaultElevation,
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.defaultRadius))),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 3, color: primaryColor)),
                          child: Padding(
                              padding:
                                  EdgeInsets.all(Constants.defaultPadding / 3),
                              child: Container(
                                width: Constants.imageWidth,
                                height: Constants.imageHeight,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage('assets/about_us/$pic'),
                                    )),
                              ))),
                    ),
                    Flexible(
                      child: ListTile(
                        // dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: primaryColor)),
                            subName.isNotEmpty
                                ? Text(subName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: primaryColor))
                                : const SizedBox(),
                            SizedBox(height: Constants.defaultPadding / 2),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Constants.defaultPadding),
                                child: FittedBox(
                                  child: Text(description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding,
                    vertical: Constants.defaultPadding / 3),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(Constants.defaultRadius * 2),
                        bottomRight:
                            Radius.circular(Constants.defaultRadius * 2)),
                    color: primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding),
                    child: FittedBox(
                      child: Text(
                        position,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: widgetColor, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
