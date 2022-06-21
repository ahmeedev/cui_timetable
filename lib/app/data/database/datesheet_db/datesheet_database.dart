import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/database_utilities_methods.dart';

class DatesheetDatabase {
  Future<bool> createDatabase() async {
    await downloadFile(
      fileName: 'datesheet.csv',
      callback: insertDatesheetData,
    );
    return Future.value(true);
  }

  Future<Future<int>> insertDatesheetData(
      {required String filePath, required List<dynamic> data}) async {
    Hive.init(filePath); // initialize the data, bcz of their separate isolate.
    // fetch sections as well as teachers.

    // === opening all the boxes  //
    final box = await Hive.openBox(DBNames.info);

    final box1 = await Hive.openBox(DBNames.datesheetStudentsDB);
    await box1.clear(); //! clear the box before inserting values

    final box2 = await Hive.openBox(DBNames.datesheetTeachersDB);
    await box2.clear(); //! clear the box before inserting values

    data.removeAt(0); //! remove the header
    data = data
        .where((element) =>
            element[7].toString().trim() != "-" ||
            element[7].toString().trim() == "")
        .toList(); //! clean the empty records

    final sectionsData = <String>{};
    final sections = <String>{};

    for (var item in data) {
      sectionsData.add(item[7].trim());
    }

    for (String element in sectionsData) {
      // List<String> tokens = element.replaceAll("+", "-").split(r'-');
      List<String> tokens = element.split(r'#');
      for (var element in tokens) {
        sections.add(element); // Making pure sections without repitition.
        // print(element);
      }
    }

    await box.put(DBInfo.datesheetSections, sections.toList());

    //!  ===== Tokenizing the sections && Creating students database  ===== //

    for (var item in sections) {
      List result = data
          .where((element) => element[7].toString().contains(item))
          .toList();

      // Remove unneccesary fields
      // creating another list for this purpose
      final purified = [];
      for (var element in result) {
        purified.add([
          element[0],
          element[1],
          element[2],
          element[3],
          element[5],
          element[6],
          element[8]
        ]);
      }

      await box1.put(item, purified);
    }

    // print(box1.get("FA19-BSE-A"));

    //!  ===== Tokenizing the teachers && Creating Teachers database  ===== //

    data = data
        .where((element) =>
            element[9].toString().trim() != "-" ||
            element[9].toString().trim() == "")
        .toList(); //! clean the empty records

    final teachersData = <String>{};
    final teachers = <String>{};

    for (var item in data) {
      teachersData.add(item[9].trim());
    }

    for (String element in teachersData) {
      // List<String> tokens = element.replaceAll("+", "-").split(r'-');
      List<String> tokens = element.split(r'-');
      for (var element in tokens) {
        teachers.add(element); // Making pure sections without repitition.
        // print(element);
      }
    }

    await box.put(DBInfo.datesheetTeachers, teachers.toList());

    for (var item in teachers) {
      List result = data
          .where((element) => element[9].toString().contains(item))
          .toList();

      // Remove unneccesary fields
      // creating another list for this purpose
      final purified = [];
      for (var element in result) {
        purified.add([
          element[0], // 0. day
          element[1], // 1. day
          element[2], // 2. month
          element[3], // 3. year
          element[5], // 4. time
          element[6], // 5. room
          element[7], // 6. section
          element[8], // 7. subject
        ]);
      }

      await box2.put(item, purified);
    }

    // === Close all the boxes === //
    await box.close(); // info
    await box1.close(); // student datesheet
    await box2.close(); // teacher
    await Future.delayed(const Duration(milliseconds: 200));
    return Future<int>.value(1);
  }
}
