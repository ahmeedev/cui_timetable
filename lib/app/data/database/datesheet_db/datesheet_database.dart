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
    final sectionsData = <String>{};
    final sections = <String>{};

    data.removeAt(0); //! remove the header
    data = data
        .where((element) =>
            element[7].toString().trim() != "-" ||
            element[7].toString().trim() == "")
        .toList(); //! clean the empty records

    for (var item in data) {
      sectionsData.add(item[7].trim());
    }

    for (String element in sectionsData) {
      // List<String> tokens = element.replaceAll("+", "-").split(r'-');
      List<String> tokens = element.split(r'#');
      tokens.forEach((element) {
        sections.add(element); // Making pure sections without repitition.
        // print(element);
      });
    }

    final box = await Hive.openBox(DBNames.info);
    await box.put(DBInfo.datesheetSections, sections.toList());

    //  ===== Tokenizing the sections && Creating students database  ===== //
    final box1 = await Hive.openBox(DBNames.datesheetDB);
    await box1.clear(); //! clear the box before inserting values

    for (var item in sections) {
      List result = await data
          .where((element) => element[7].toString().contains(item))
          .toList();

      // Remove unneccesary fields
      // creating another list for this purpose
      final purified = [];
      result.forEach((element) {
        purified.add([
          element[0],
          element[1],
          element[2],
          element[3],
          element[5],
          element[6],
          element[8]
        ]);
      });

      await box1.put(item, purified);
    }

    // print(box1.get("FA19-BSE-A"));

    await box.close(); // info
    await box1.close(); // datesheet
    await Future.delayed(const Duration(milliseconds: 200));
    return Future<int>.value(1);
  }
}
