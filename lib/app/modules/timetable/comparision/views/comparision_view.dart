import 'package:cui_timetable/app/modules/timetable/comparision/views/widgets/comparison_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/comparison_controller.dart';

class ComparisonView extends GetView<ComparisonController> {
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final keys = ['10000', '1000', '100', '10', '1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[0]),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Row(children: [
                    ...List.generate(5, (index) {
                      return DayTile(
                        day: days[index].toString(),
                        dayKey: keys[index].toString(),
                        callback: controller.allFalse,
                        obs: controller.giveValue(index),
                      );
                    })
                  ])),
            ),
            Flexible(
              flex: Constants.lectureFlex,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text("${Get.arguments[1]}"),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
