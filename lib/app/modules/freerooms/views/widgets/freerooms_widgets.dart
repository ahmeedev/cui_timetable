import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayTile extends StatelessWidget {
  final String day;
  final Function callback;
  final Rx<bool> obs;
  const DayTile(
      {required this.day, required this.callback, required this.obs, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: 1,
          child: Card(
            color: widgetColor,
            elevation: Constants.defaultElevation / 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.defaultPadding * 2.5),
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 5,
                              decoration: const BoxDecoration(
                                  gradient:
                                      LinearGradient(colors: successGradient)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          )),
    );
  }
}

class FreeroomsMainExpansionTile extends StatelessWidget {
  final String slot;
  final bool expanded;

  const FreeroomsMainExpansionTile(
      {Key? key, required this.slot, required this.expanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: widgetColor,
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        maintainState: true,
        leading: ImageIcon(
          AssetImage('assets/freerooms/timer.png'),
          size: Constants.iconSize,
          // color: primaryColor,
        ),
        childrenPadding: EdgeInsets.all(Constants.defaultPadding / 2),
        collapsedBackgroundColor: widgetColor,
        backgroundColor: expandedColor,
        iconColor: primaryColor,
        title: Text(
          slot,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),
        ),
        children: const [
          FreeroomsClassesExpensionTile(),
          FreeroomsLabsExpensionTile(),
        ],
      ),
    );
  }
}

class FreeroomsClassesExpensionTile extends StatelessWidget {
  const FreeroomsClassesExpensionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
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
          padding: EdgeInsets.only(top: Constants.defaultPadding / 3),
          child: Text(
            '12',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
          ),
        ),
        children: [
          FreeroomsDepartmentWiseExpensionTile(
            department: 'A',
          ),
          FreeroomsDepartmentWiseExpensionTile(
            department: 'B',
          ),
          FreeroomsDepartmentWiseExpensionTile(
            department: 'C',
          ),
          FreeroomsDepartmentWiseExpensionTile(
            department: 'W',
          ),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding / 2),
          //   child: GridView.count(
          //     physics: const ScrollPhysics(),
          //     shrinkWrap: true,
          //     crossAxisCount: 4,
          //     scrollDirection: Axis.vertical,
          //     children: [
          //       ...List.generate(
          //           12,
          //           (index) => const FreeRoomsTile(
          //                 room: "A1.1",
          //               ))
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class FreeroomsLabsExpensionTile extends StatelessWidget {
  const FreeroomsLabsExpensionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
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
          padding: EdgeInsets.only(top: Constants.defaultPadding / 3),
          child: Text(
            '12',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              scrollDirection: Axis.vertical,
              children: [
                ...List.generate(
                    12,
                    (index) => const FreeroomsTile(
                          room: "A1.1",
                        ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FreeroomsDepartmentWiseExpensionTile extends StatelessWidget {
  final department;
  const FreeroomsDepartmentWiseExpensionTile(
      {Key? key, required this.department})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
      child: Card(
        shadowColor: shadowColor,
        elevation: Constants.defaultElevation,
        child: ExpansionTile(
          collapsedBackgroundColor: widgetColor,
          backgroundColor: expandedColor,
          onExpansionChanged: (value) {},
          title: Text(
            '$department dept',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: Constants.defaultPadding / 3),
            child: Text(
              '12',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding / 2),
              child: GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                children: [
                  ...List.generate(
                      12,
                      (index) => const FreeroomsTile(
                            room: "A1.1",
                          ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FreeroomsTile extends StatelessWidget {
  final String room;
  const FreeroomsTile({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius))),
        color: widgetColor,
        elevation: Constants.defaultElevation / 2,
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
