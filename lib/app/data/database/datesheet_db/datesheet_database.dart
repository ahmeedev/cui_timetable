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
    final sectionsData = <String>{};
    final sections = <String>{};

    data.removeAt(0); //! remove the header
    data = data
        .where((element) => element[7].toString() != "-")
        .toList(); //! clean the empty records

    for (var item in data) {
      sectionsData.add(item[7].trim());
    }

    for (String element in sectionsData) {
      List<String> tokens = element.replaceAll("+", "-").split(r'-');
      final result = await _tokenizeSection(tokens: tokens);
      result.forEach((element) {
        sections.add(element); // Making pure sections without repitition.
      });
    }

    final box = await Hive.openBox(DBNames.info);
    await box.put(DBInfo.datesheetSections, sections.toList());

    //  ===== Tokenizing the sections && Creating students database  ===== //
    final box1 = await Hive.openBox(DBNames.datesheetDB);

    for (var item in data) {
      List<String> tokens = item[7].replaceAll("+", "-").split(r'-');
      final result = await _tokenizeSection(tokens: tokens);
      List<String> subjects = item[8].split('-');

      for (var i = 0; i < result.length; i++) {
        List data = box1.get(result[i], defaultValue: []);
        data.add([
          item[0],
          item[1],
          item[2],
          item[3],
          item[5].toString().replaceAll("00", ":00").replaceAll("30", ":30"),
          item[6],
          subjects.length == 1 ? subjects[0] : subjects[1]
        ]);
        await box1.put(result[i], data);
      }
    }

    // box1.put(key, value)
    box.close();
    box1.close();
    await Future.delayed(const Duration(milliseconds: 300));
    return Future<int>.value(1);
  }

  List<String> _tokenizeSection({tokens}) {
    List<String> result = [];
    var section;
    for (var i = 0; i < tokens.length; i++) {
      if (tokens[i].length == 4) {
        section = "";
        section = tokens[i] + "-";
      } else if (tokens[i].length == 3) {
        section += tokens[i];
        if (i == tokens.length - 1 || tokens[i + 1].length == 4) {
          result.add(section);
        }
      } else if (tokens[i].length == 1) {
        section += "-" + tokens[i];
        if (i != tokens.length - 1 && tokens[i + 1].length == 4) {
          result.add(section);
        } else if (i == tokens.length - 1) {
          result.add(section);
        }
      }
    }
    // print("tokens: $tokens");
    // print("result: ${result}");
    return result;
  }
}
