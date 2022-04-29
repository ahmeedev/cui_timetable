import 'package:cui_timetable/style.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            AboutUsTile(
              pic: 'ahmad.jpg',
              name: 'Ahmad Shaf',
              position: 'Team Manager',
              description: 'CUI Software House Coordinator',
            ),
            AboutUsTile(
              pic: 'ahmad.jpg',
              name: 'Ahmad Tariq',
              position: 'Developer',
              description: 'CUI Computer Science Student',
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsTile extends StatelessWidget {
  String pic;
  String name;
  String position;
  String description;
  AboutUsTile(
      {Key? key,
      required this.pic,
      required this.name,
      required this.position,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Stack(children: [
        Positioned(
          left: 30,
          right: 0,
          top: 5,
          child: Card(
            color: widgetColor,
            shadowColor: shadowColor,
            elevation: defaultElevation,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: primaryColor, fontSize: 18)),
                    const SizedBox(height: 10),
                    Text(description,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black)),
                  ],
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
                width: 110,
                height: 110,
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
