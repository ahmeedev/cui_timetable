import 'package:cui_timetable/app/modules/home/views/home_view3.dart';
import 'package:cui_timetable/app/modules/news/views/news_view.dart';
import 'package:cui_timetable/app/modules/settings/views/settings_view2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:cui_timetable/app/utilities/location/loc_utilities.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final internet = true.obs;
  final newUpdate = false.obs;
  var isLarge = true;
  // final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);
  final isHome = true.obs;
  final isSetting = false.obs;
  final isNews = false.obs;

  final pageLabels = ['News', 'CUI SAHIWAL', 'Settings'];
  final pageWidget = [
    const NewsView(),
    const HomeViewWidget(),
    const SettingsView2()
  ];
  final pageIndex = 1.obs;

  late final Box authCache;

  var isUserSignIn = false.obs;
  @override
  Future<void> onInit() async {
    // authCache = await Hive.openBox(DBNames.authCache);

    if (FirebaseAuth.instance.currentUser?.uid == null) {
      isUserSignIn.value = false;
    } else {
      isUserSignIn.value = true;
    }

    FlutterNativeSplash.remove();
    super.onInit();
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

  /// set the navigationBar container color.
  void setToFalse() {
    isHome.value = false;
    isSetting.value = false;
    isNews.value = false;
  }
}

// Carousel Methods
Future<List<Map<String, String>>> _fetchImgFromInternet(location) async {
  const src = "https://sahiwal.comsats.edu.pk/";
  var url = Uri.parse(src);
  var response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);
  final List<Map<String, String>> list = [];
  final result = html
      .querySelectorAll("#layerslider-container-fw >#layerslider >.ls-layer");

  for (var element in result) {
    final text = element.getElementsByClassName("plus2");
    String title = '';
    if (text.isNotEmpty) {
      title = text[0].text.trim();
    }
    final img = element.getElementsByTagName("img")[0];
    // print(img.attributes["src"]);

    list.add({"title": title, "img": "$src${img.attributes["src"]}"});
  }

  return list;
}
