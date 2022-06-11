import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/database_utilities_methods.dart';

// Flutter imports:

// Package imports:

// Project imports:

class FreeRoomsDatabase {
  Future<bool> createDatabase({required lastEntity}) async {
    await closeDatabases();

    await downloadFile(
        fileName: 'freerooms.csv',
        lastEntity: lastEntity,
        callback: insertFreeRoomsData);
    return Future.value(true);
  }
}

//! All the code run in working Isolate, Be aware
void insertFreeRoomsData(
    {required String filePath, required List<List<dynamic>> data}) async {
  Hive.init(filePath); // initialize the data, bcz of their separate isolate.
  await deleteData();

  var list;
  final box = await Hive.openBox(DBNames.freerooms);
  list = [data[1], data[2], data[3], data[4], data[5]];
  // Remove the unnecessary monday keyword
  for (List i in list) {
    i.removeAt(0);
    i.removeAt(0);
  }
  await box.put(DBFreerooms.monday, list);
  await Future.delayed(const Duration(milliseconds: 100));

  list = [data[7], data[8], data[9], data[10], data[11]];
  // Remove the unnecessary monday keyword
  for (List i in list) {
    i.removeAt(0);
    i.removeAt(0);
  }
  await box.put(DBFreerooms.tuesday, list);
  await Future.delayed(const Duration(milliseconds: 100));

  list = [data[13], data[14], data[15], data[16], data[17]];
  // Remove the unnecessary monday keyword
  for (List i in list) {
    i.removeAt(0);
    i.removeAt(0);
  }
  await box.put(DBFreerooms.wednesday, list);
  await Future.delayed(const Duration(milliseconds: 100));

  list = [data[19], data[20], data[21], data[22], data[23]];
  // Remove the unnecessary monday keyword
  for (List i in list) {
    i.removeAt(0);
    i.removeAt(0);
  }
  await box.put(DBFreerooms.thursday, list);
  await Future.delayed(const Duration(milliseconds: 100));

  list = [data[25], data[26], data[27], data[28], data[29]];
  // Remove the unnecessary monday keyword
  for (List i in list) {
    i.removeAt(0);
    i.removeAt(0);
  }
  await box.put(DBFreerooms.friday, list);
  await Future.delayed(const Duration(milliseconds: 100));

  Hive.close();
  await Future.delayed(const Duration(milliseconds: 300));
}

Future<void> deleteData() async {
  var box = await Hive.openBox(DBNames.freerooms);
  try {
    await box.clear();
  } catch (e) {
    debugPrint(e.toString());
  } finally {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
