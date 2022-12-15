import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../utilities/notifications/cloud_notifications.dart';
import '../../../../widgets/get_widgets.dart';
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
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await sendNotification(
                topic: 'all',
                title: "Asalam o alaikum",
                description: 'This is a cloud tesing notification');
            GetXUtilities.snackbar(
                duration: 3,
                title: 'Cloud Notification',
                message: result.body.toString(),
                gradient: successGradient);
          },
          child: const Text(
            'Test Notification',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
