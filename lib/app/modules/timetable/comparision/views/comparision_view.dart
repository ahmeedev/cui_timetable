import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/comparision_controller.dart';

class ComparisionView extends GetView<ComparisionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments[0]),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          Get.arguments[1],
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
