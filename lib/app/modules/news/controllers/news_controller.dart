import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';
import '../../../utilities/location/loc_utilities.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  final internet = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  /// Stream for the News.
  Stream<dynamic> getNewsStream() async* {
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

// News Methods

_fetchNewsFromInternet(location) async {
  var html = await _getDocument(
      address: "https://sahiwal.comsats.edu.pk/Default.aspx");

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

  var html2 =
      await _getDocument(address: 'https://swl-cms.comsats.edu.pk:8082/');

  var result = _purifyNoticeboardNews(
      string: html2.querySelector(".notice_board >ul >li")!.text.toString());

  list.add({"title": "Noticeboard #${list.length - 1}", "description": result});

  result = _purifyNoticeboardNews(
      string: result = html2
          .querySelector(".notice_board >ul >li")!
          .nextElementSibling!
          .text
          .toString());

  list.add({"title": "Noticeboard #${list.length - 1}", "description": result});

  // putting into box for cache purpose\
  Hive.init(location);
  final box = await Hive.openBox(DBNames.info);
  await box.put(DBInfo.news, list);
  box.close();
  return list;
}

_getDocument({address}) async {
  var url = Uri.parse(address);
  var response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);
  return html;
}

_fetchNewsFromCache(location) async {
  Hive.init(location);
  final box = await Hive.openBox(DBNames.info);
  final news = box.get(DBInfo.news, defaultValue: []);
  return news;
}

_purifyNoticeboardNews({string}) {
  return string
      .trim()
      .replaceAll(RegExp('\n'), '')
      .replaceAll('Dear Students:', 'Dear Students:\n');
}
