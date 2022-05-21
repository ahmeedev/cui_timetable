import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class HomeController extends GetxController {
  final internet = true.obs;
  // @override
  // Future<void> onInit() async {}

  Stream<dynamic> getStream() async* {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      internet.value = false;
    }

    if (internet.value) {
      final result =
          await compute(_fetchNewsFromInternet, LocationUtilities.defaultpath);
      yield result;
    } else {
      final result =
          await compute(_fetchNewsFromCache, LocationUtilities.defaultpath);
      yield result;
    }
    // yield list;
  }
}

_fetchNewsFromInternet(location) async {
  final url = Uri.parse('https://sahiwal.comsats.edu.pk/Default.aspx');
  final response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);

  final titles = html
      .querySelectorAll('#myNews >h4')
      .map((e) => e.text
          .trim()
          .replaceAll(RegExp('[ ]{2,}'), "")
          .replaceAll(RegExp('\n'), ''))
      .toList();

  final description = html
      .querySelectorAll('#myNews >p')
      .map(
        (e) => e.text
            .trim()
            .replaceAll(RegExp('[ ]{2,}'), "")
            .replaceAll(RegExp('\n'), ' ')
            .replaceAll('Dear Students, ', 'Dear Students,\n')
            .replaceAll('.', '. '),
      )
      .toList();
  var list = [];
  for (var i = 0; i < titles.length; i++) {
    list.add({"title": titles[i], "description": description[i]});
  }

  // putting into box for cache purpose\
  Hive.init(location);
  final box = await Hive.openBox(DBNames.info);
  await box.put(DBInfo.news, list);
  box.close();
  return list;
}

_fetchNewsFromCache(location) async {
  Hive.init(location);
  final box = await Hive.openBox(DBNames.info);
  final news = box.get(DBInfo.news, defaultValue: []);
  return news;
}
