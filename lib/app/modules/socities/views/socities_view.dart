import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/socities_controller.dart';

class SocitiesView extends GetView<SocitiesController> {
  const SocitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SocitiesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SocitiesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
