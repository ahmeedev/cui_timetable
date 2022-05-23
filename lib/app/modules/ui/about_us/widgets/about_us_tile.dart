
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Stack(children: [
        Positioned(
          left: 40,
          right: 0,
          top: 5,
          child: Card(
            color: widgetColor,
            shadowColor: shadowColor,
            elevation: defaultElevation,
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:defaultPadding*2),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: primaryColor, fontSize: 14)),
                      subName.isNotEmpty
                          ? Text(subName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: primaryColor, fontSize: 14))
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      Text(description,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: primaryColor)),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 3),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/about_us/$pic'),
                    )),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: defaultPadding / 2, top: 2),
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(defaultRadius * 2),
                    bottomRight: Radius.circular(defaultRadius * 2)),
                color: primaryColor,
              ),
              child: Text(
                position,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: widgetColor),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
