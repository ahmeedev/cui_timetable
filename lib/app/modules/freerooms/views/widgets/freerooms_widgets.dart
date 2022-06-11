import 'package:cui_timetable/app/modules/freerooms/controllers/freerooms_controller.dart';
import 'package:cui_timetable/app/modules/freerooms/models/freerooms_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

class DayTile extends GetView<FreeroomsController> {
  final String day;
  final String dayKey;
  final Function callback;
  final Rx<bool> obs;
  const DayTile(
      {required this.day,
      required this.dayKey,
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
          child: Card(
            color: widgetColor,
            elevation: Constants.defaultElevation / 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Obx(() => Container(
                  decoration: BoxDecoration(
                      color: obs.value ? selectionColor : widgetColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        callback();
                        controller.getFreerooms(day: day);
                        obs.value = true;
                        // controller.
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(day,
                              style: Theme.of(context).textTheme.titleMedium),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.defaultPadding * 3),
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
  final totalClasses;
  List<FreeroomsSubClass> classes;
  final totalLabs;
  final labs;

  FreeroomsMainExpansionTile(
      {Key? key,
      required this.slot,
      required this.totalClasses,
      required this.classes,
      required this.totalLabs,
      required this.labs,
      required this.expanded})
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
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
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
          children: [
            FreeroomsClassesExpensionTile(
              totalClasses: totalClasses,
              classes: classes,
            ),
            // FreeroomsLabsExpensionTile(),
          ],
        ),
      ),
    );
  }
}

class FreeroomsClassesExpensionTile extends StatelessWidget {
  final dept = ['A', 'B', 'C', 'W'];
  final totalClasses;
  List<FreeroomsSubClass> classes;
  FreeroomsClassesExpensionTile(
      {Key? key, required this.totalClasses, required this.classes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: Constants.defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
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
              totalClasses.toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
          ),
          children: [
            Expanded(
              child: ListView.builder(
                // itemCount: dept.length,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return FreeroomsDepartmentWiseExpensionTile(
                    department: dept[index],
                    availableClasses: classes[index].classes,
                  );
                },
              ),
            ),
            SizedBox(
              height: Constants.defaultPadding,
            )
          ],
        ),
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
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Constants.defaultRadius)),
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
      ),
    );
  }
}

class FreeroomsDepartmentWiseExpensionTile extends StatelessWidget {
  final department;
  final List availableClasses;
  const FreeroomsDepartmentWiseExpensionTile(
      {Key? key, required this.department, required this.availableClasses})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
      child: Card(
        shadowColor: shadowColor,
        elevation: Constants.defaultElevation,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius))),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius)),
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
                padding: EdgeInsets.all(Constants.defaultPadding / 2),
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
        color: widgetColor,
        elevation: Constants.defaultElevation,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius))),
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
