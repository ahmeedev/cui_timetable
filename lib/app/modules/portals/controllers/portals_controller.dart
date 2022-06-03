import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PortalsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement PortalsController
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
