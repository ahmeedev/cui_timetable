import 'package:cui_timetable/controllers/freerooms/freerooms_controller.dart';
import 'package:cui_timetable/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeRooms extends StatelessWidget {
  FreeRooms({Key? key}) : super(key: key);
  final controller = Get.find<FreeRoomsController>();
  final daysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final slots = [
    "08:00AM - 10:00AM",
    "10:00AM - 11:30AM",
    "11:30AM - 01:00PM",
    "01:30PM - 3:00PM",
    "03:00PM - 04:30PM"
  ];

  //* Testing list
  final nORooms = [3, 2, 1, 4, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Free Rooms'),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Row(children: [
                  ...List.generate(5, (index) {
                    return DayTile(
                      day: daysList[index],
                      nOfRooms: nORooms[index],
                      callback: controller.allFalse,
                      obs: controller.giveValue(index),
                    );
                  })
                ]),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Flexible(
              flex: 6,
              child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: ListView(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        FreeRoomsMainExpansionTile(
                            slot: '10:00AM - 11:00AM', expanded: true),
                        FreeRoomsMainExpansionTile(
                            slot: '11:00AM - 12:00PM', expanded: false),
                        FreeRoomsMainExpansionTile(
                            slot: '02:00PM - 03:00PM', expanded: false),
                        FreeRoomsMainExpansionTile(
                            slot: '03:00PM - 04:00PM', expanded: false),
                        FreeRoomsMainExpansionTile(
                            slot: '12:00PM - 01:00PM', expanded: false),
                      ])),
            ),
          ],
        ));
  }
}

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
        backgroundColor: scaffoldColor,
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
        backgroundColor: scaffoldColor,
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
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            children: [
              ...List.generate(
                  12,
                  (index) => LectureDetailsTile(
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
        backgroundColor: scaffoldColor,
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
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            children: [
              ...List.generate(
                  12,
                  (index) => LectureDetailsTile(
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
  final day;
  final nOfRooms;
  final callback;
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
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(nOfRooms.toString()),
                          ],
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                  )),
            ),
          )),
    );
  }
}

class LectureDetailsTile extends StatelessWidget {
  LectureDetailsTile({
    Key? key,
    required this.room,
  }) : super(key: key);
  late final slot;
  late final room;
  late final Widget img;

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
