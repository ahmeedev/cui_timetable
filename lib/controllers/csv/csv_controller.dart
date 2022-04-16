import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer' as devlog;
import 'package:flutter/services.dart' show rootBundle;

import 'dart:async';

class CsvController extends GetxController {
  Future<List<List<dynamic>>> loadCSV() async {
    devlog.log('Loading Csv File...', name: 'CSV');
    final _rawData = await rootBundle.loadString("assets/csv/timetable.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter(eol: '\n', fieldDelimiter: ',')
            .convert(_rawData);
    devlog.log('Csv File Retrieved...', name: 'CSV');
    return _listData;
  }

  /// Fetching Sections from the file
  Future<Set<String>> fetchSections(csvData) async {
    final sections = <String>{};

    for (var i in csvData) {
      sections.add(i[0]);
    }
    devlog.log('Sections Retreived...', name: 'OPERATION');
    print(sections);
    return sections;
  }
}
