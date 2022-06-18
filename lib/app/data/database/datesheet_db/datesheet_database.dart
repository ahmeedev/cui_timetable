import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/data/database/database_utilities_methods.dart';
import 'package:hive/hive.dart';

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
    // await deleteData();
    // fetch sections as well as teachers.
    final sections = <String>{};
    // final teachers = <String>{};

    for (var item in data) {
      sections.add(item[7].trim());
    }
    sections.remove('Section'); //! remove the freeroom value
    sections.remove('-'); //! remove the freeroom value
    print(sections.length);

//  ===== Tokenizing the sections && Creating students database  ===== //
    final box1 = await Hive.openBox(DBNames.datesheetDB);

    for (String element in sections) {
      List tokens = element.split(r'-');
      print(tokens[0].length);
    }

    return Future<int>.value(1);
  }
}
