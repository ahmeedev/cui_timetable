import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/developer_controller.dart';

class DeveloperView extends GetView<DeveloperController> {
  const DeveloperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeveloperView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DeveloperView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
