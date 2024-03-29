import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PortalsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void increment() => count.value++;
}
