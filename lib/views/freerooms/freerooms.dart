import 'package:cui_timetable/controllers/freerooms/freerooms_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FreeRooms extends StatelessWidget {
  FreeRooms({Key? key}) : super(key: key);
  final freeRoomsController = Get.find<FreeRoomsController>();
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

  final Widget svg = Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: SvgPicture.asset(
      'assets/freerooms/classroom.svg',
      width: 100,
      height: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Rooms'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  // size: 28,
                ))
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Container(
                  child: Row(children: [
                    ...List.generate(5, (index) {
                      return DayTile(
                        daysList[index],
                        nORooms[index],
                        freeRoomsController.allFalse,
                        freeRoomsController.giveValue(index),
                      );
                    })
                  ]),
                ),
              ),
            ),
            Flexible(
              flex: 6,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return LectureDetailsTile(
                      slot: index < 5 ? slots[index] : slots[2],
                      room: "A1.1",
                      img: svg,
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class DayTile extends StatelessWidget {
  DayTile(this.day, this.nOfRooms, this.callback, this.obs, {Key? key})
      : super(key: key);

  late final day;
  late final nOfRooms;
  late final callback;
  late Rx<bool> obs;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 0.8,
          widthFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: obs.value ? Colors.grey.shade200 : Colors.white,
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
                            Text(day),
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
  LectureDetailsTile(
      {Key? key,
      required this.slot,
      required this.room,
      required Widget this.img})
      : super(key: key);
  late final slot;
  late final room;
  late final Widget img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 4),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                img,
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        room.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Icon(
                        Icons.timer,
                        size: 30,
                        color: Colors.blue,
                      ),
                      Text(slot.toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
