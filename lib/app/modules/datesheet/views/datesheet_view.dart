import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/datesheet_controller.dart';

class DatesheetView extends GetView<DatesheetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DatesheetView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DatesheetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
