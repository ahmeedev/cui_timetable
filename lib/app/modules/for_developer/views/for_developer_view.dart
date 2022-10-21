import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/for_developer_controller.dart';

class ForDeveloperView extends GetView<ForDeveloperController> {
  const ForDeveloperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForDeveloperView'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: ElevatedButton(
                    onPressed: () async {
                      await controller.syncAllFiles();
                    },
                    child: const Text("Sync Files").paddingAll(16))
                .paddingAll(16),
          )
        ],
      ).paddingAll(16),
    );
  }
}
