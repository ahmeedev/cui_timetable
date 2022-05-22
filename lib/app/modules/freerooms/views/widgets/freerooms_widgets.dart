import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeRoomsMainExpansionTile extends StatelessWidget {
  final String slot;
  final bool expanded;

  const FreeRoomsMainExpansionTile(
      {Key? key, required this.slot, required this.expanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: widgetColor,
      shadowColor: shadowColor,
      elevation: defaultElevation,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        maintainState: true,
        leading: const ImageIcon(
          AssetImage('assets/freerooms/timer.png'),
          size: iconSize,
          // color: primaryColor,
        ),
        childrenPadding: const EdgeInsets.all(defaultPadding / 2),
        collapsedBackgroundColor: widgetColor,
        backgroundColor: expandedColor,
        iconColor: primaryColor,
        title: Text(
          slot,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),
        ),
        children: const [
          FreeRoomsClassesExpensionTile(),
          FreeRoomsLabsExpensionTile(),
        ],
      ),
    );
  }
}

class FreeRoomsClassesExpensionTile extends StatelessWidget {
  const FreeRoomsClassesExpensionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: defaultElevation,
      child: ExpansionTile(
        collapsedBackgroundColor: widgetColor,
        backgroundColor: textFieldColor,
        onExpansionChanged: (value) {},
        title: Text(
          'Classes',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: defaultPadding / 3),
          child: Text(
            '12',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
          ),
        ),
        children: [
          GridView.count(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            scrollDirection: Axis.vertical,
            children: [
              ...List.generate(
                  12,
                  (index) => const LectureDetailsTile(
                        room: "A1.1",
                      ))
            ],
          ),
        ],
      ),
    );
  }
}

class FreeRoomsLabsExpensionTile extends StatelessWidget {
  const FreeRoomsLabsExpensionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: defaultElevation,
      child: ExpansionTile(
        collapsedBackgroundColor: widgetColor,
        backgroundColor: textFieldColor,
        onExpansionChanged: (value) {},
        title: Text(
          'Labs',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: defaultPadding / 3),
          child: Text(
            '12',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
          ),
        ),
        children: [
          GridView.count(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            scrollDirection: Axis.vertical,
            children: [
              ...List.generate(
                  12,
                  (index) => const LectureDetailsTile(
                        room: "A1.1",
                      ))
            ],
          ),
        ],
      ),
    );
  }
}

class DayTile extends StatelessWidget {
  final String day;
  final int nOfRooms;
  final Function callback;
  final Rx<bool> obs;
  const DayTile(
      {required this.day,
      required this.nOfRooms,
      required this.callback,
      required this.obs,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              color: widgetColor,
              elevation: defaultElevation / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: obs.value ? selectionColor : widgetColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          callback();
                          obs.value = true;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(day,
                                style: Theme.of(context).textTheme.titleMedium),
                            Text(
                              nOfRooms.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 2.5),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 5,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: successGradient)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          )),
    );
  }
}

class LectureDetailsTile extends StatelessWidget {
  final String room;
  const LectureDetailsTile({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
        color: widgetColor,
        elevation: defaultElevation / 2,
        shadowColor: shadowColor,
        child: Center(
          child: Text(
            room.toString(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
