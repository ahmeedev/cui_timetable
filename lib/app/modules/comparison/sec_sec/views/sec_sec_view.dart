import 'package:cui_timetable/app/modules/comparison/sec_sec/views/widgets/sec_sec_view_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sec_sec_controller.dart';

class SecSecView extends GetView<SecSecController> {
  const SecSecView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Lectures'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: controller.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: Get.height * 0.2,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                // scrollDirection: Axis.horizontal,
                children: [
                  ...List.generate(5, (index) {
                    return DayTile(
                      // day: days[index].toString(),
                      dayKey: controller.days[index],
                      // callback: controller.allFalse,
                      // obs: controller.giveValue(index),
                    );
                  }),
                ],
              ),
            );
            // return Text(snapshot.data["10000"].toString());
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
