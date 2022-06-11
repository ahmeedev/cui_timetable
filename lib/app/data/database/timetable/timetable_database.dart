import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/database_utilities_methods.dart';

// Flutter imports:

// Package imports:

// Project imports:

class TimetableDatabase {
  // String search_section = '';

  Future<bool> createDatabase() async {
    await closeDatabases();
    await downloadFile(
      fileName: 'timetable.csv',
      callback: insertTimetableData,
    );
    return Future.value(true);
  }

  //! All the code run in working Isolate, Be aware

  Future<Future<int>> insertTimetableData(
      {required String filePath, required List<dynamic> data}) async {
    Hive.init(filePath); // initialize the data, bcz of their separate isolate.
    await deleteData();
    // fetch sections as well as teachers.
    final sections = <String>{};
    final teachers = <String>{};

    for (var item in data) {
      sections.add(item[0].trim());
      teachers.add(item[4].trim());
    }

    //  =====  creating students database  ===== //
    final box1 = await Hive.openBox(DBNames.studentsDB);

    for (var i in sections) {
      var lectures = data
          .toList()
          .where((element) =>
              element[0].toString().toLowerCase() == i.toLowerCase())
          .toList();
      await box1.put(i.toLowerCase(), lectures);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    await box1.close();

    //  =====  creating teachers database  ===== //
    final box2 = await Hive.openBox(DBNames.teachersDB);

    for (var i in teachers) {
      var lectures = data
          .toList()
          .where((element) =>
              element[4].toString().toLowerCase() == i.toLowerCase())
          .toList();
      await box2.put(i.toLowerCase(), lectures);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    await box2.close();

    //  =====  storing  students and teachers list  ===== //
    final box3 = await Hive.openBox(DBNames.info);
    await box3.put(DBInfo.sections, sections.toList());
    await box3.put(DBInfo.teachers, teachers.toList());
    await Future.delayed(const Duration(milliseconds: 500));

    await box3.close();

    // Hive.close();

    return Future<int>.value(1);
  }

  Future<void> deleteData() async {
    var box = await Hive.openBox(DBNames.info);
    try {
      var sections = box.get(DBInfo.sections);
      for (var i in sections) {
        // final box = await Hive.openBox(i);
        Hive.deleteBoxFromDisk(i);
      }
      var teachers = box.get(DBInfo.teachers);
      for (var i in teachers) {
        Hive.deleteBoxFromDisk(i);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      box.deleteAll([DBInfo.sections, DBInfo.teachers]);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }
}
