import 'package:flutter/foundation.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';

class HomeController extends GetxController {
  final internet = true.obs;
  final newUpdate = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    FlutterNativeSplash.remove();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    final box = await Hive.openBox(DBNames.info);
    final newUser = await box.get(DBInfo.newUser, defaultValue: true);
    if (newUser) {
      final controller = Get.find<SyncController>();
      controller.syncData(dialogPop: true);
    } else {
      await getRemoteVersion().then((value) {
        if (box.get(DBInfo.version).toString() != value) {
          newUpdate.value = true;
        }
      });
    }
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

  /// Stream for the carousel.
  Stream<List<Map<String, String>>> getCarouselStream() async* {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      internet.value = false;
    }

    if (internet.value) {
      final result =
          await compute(_fetchImgFromInternet, LocationUtilities.defaultpath);

      yield result;
    } else {
      // final result =
      //     await compute(_fetchImgFromInternet, LocationUtilities.defaultpath);

      // yield [];
      internet.value = false;
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

  list.add({"title": "Noticeboard #${list.length}", "description": result});

  result = _purifyNoticeboardNews(
      string: result = await html2
          .querySelector(".notice_board >ul >li")!
          .nextElementSibling!
          .text
          .toString());

  list.add({"title": "Noticeboard #${list.length}", "description": result});

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
  dom.Document html = await dom.Document.html(response.body);
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

// Carousel Methods
Future<List<Map<String, String>>> _fetchImgFromInternet(location) async {
  final src = "https://sahiwal.comsats.edu.pk/";
  var url = Uri.parse(src);
  var response = await http.get(url);
  dom.Document html = await dom.Document.html(response.body);
  final List<Map<String, String>> list = [];
  final result = await html
      .querySelectorAll("#layerslider-container-fw >#layerslider >.ls-layer");

  result.forEach((element) {
    final text = element.getElementsByClassName("plus2");
    String title = '';
    if (text.length != 0) {
      title = text[0].text.trim();
    }
    final img = element.getElementsByTagName("img")[0];
    // print(img.attributes["src"]);

    list.add({"title": title, "img": "$src${img.attributes["src"]}"});
  });

  return list;
}
