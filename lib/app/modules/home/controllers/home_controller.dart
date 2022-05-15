import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class HomeController extends GetxController {
  final internet = true.obs;
  @override
  Future<void> onInit() async {}

  Stream<dynamic> getStream() async* {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
    } else if (result == ConnectivityResult.mobile) {
    } else {
      internet.value = false;
    }
    if (internet.value) {
      final result = await compute(_fetchNewsFromInternet, true);
      yield result;
    } else {}
    // yield list;
  }
}

_fetchNewsFromInternet(deme) async {
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
            .replaceAll(RegExp('\n'), '')
            .replaceAll('Dear Students,', 'Dear Students,\n'),
      )
      .toList();
  var list = [];
  for (var i = 0; i < titles.length; i++) {
    list.add({"title": titles[i], "description": description[i]});
  }
  return list;
}
