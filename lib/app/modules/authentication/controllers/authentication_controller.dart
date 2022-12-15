import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  // final pageIndex = 0.obs;
  final isSignIn = true.obs;
  final titles = ["SIGN IN", "SIGN UP"];

  var normalStyle = const TextStyle(
      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w900);
  var selectedStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900);

  var segmentedControlGroupValue = 0.obs;
  Map<int, Widget>? myTabs;
  var styles = [].obs;

  var infoMsg = <String>[].obs;

  var respectedEmailSuffixes = ['@gmail.com', '@gmail.com'];

  @override
  void onInit() {
    styles.add(selectedStyle);
    styles.add(normalStyle);
    styles.add(normalStyle);
    myTabs = <int, Widget>{
      0: Obx(() => Text("Students", style: styles[0])),
      1: Obx(() => Text("Faculty", style: styles[1])),
    };

    super.onInit();
  }
}
