import 'package:cui_timetable/controllers/database/database_controller.dart';
import 'package:cui_timetable/controllers/developer/developer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Developer extends StatelessWidget {
  final developerController = Get.find<DeveloperController>();
  final databaseController = Get.find<DatabaseController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Database Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      databaseController.insertData();
                      Get.snackbar('HIVE', 'Boxes Inserted into Disk',
                          snackPosition: SnackPosition.BOTTOM,
                          snackStyle: SnackStyle.GROUNDED,
                          backgroundColor: Colors.black,
                          colorText: Colors.white);
                    },
                    child: const Text('Insert Data'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        developerController.retreive();
                        Get.snackbar('HIVE', 'Boxes Retrieved from Disk',
                            snackPosition: SnackPosition.BOTTOM,
                            snackStyle: SnackStyle.GROUNDED,
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                      },
                      child: const Text('Retreived Data')),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(primary: Colors.red),
                  //   onPressed: () {
                  //     databaseController.deleteBoxes();
                  //     Get.snackbar('HIVE', 'Boxes Deleted from Disk',
                  //         snackPosition: SnackPosition.BOTTOM,
                  //         snackStyle: SnackStyle.GROUNDED,
                  //         backgroundColor: Colors.black,
                  //         colorText: Colors.white);
                  //   },
                  //   child: const Text('Delete Data'),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                  child: Obx(() => ListView.builder(
                        itemCount: developerController.sections.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text(index.toString()),
                            title: Text(
                                developerController.sections[index].toString()),
                          );
                        },
                      )))
            ],
          ),
        ));
  }
}
