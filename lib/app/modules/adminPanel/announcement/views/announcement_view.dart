import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/announcement_controller.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnnouncementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AnnouncementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
