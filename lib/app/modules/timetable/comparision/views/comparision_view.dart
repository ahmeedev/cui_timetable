import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/comparision_controller.dart';

class ComparisionView extends GetView<ComparisionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ComparisionUiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ComparisionUiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
