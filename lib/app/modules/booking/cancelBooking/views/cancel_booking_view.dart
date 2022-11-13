import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cancel_booking_controller.dart';

class CancelBookingView extends GetView<CancelBookingController> {
  const CancelBookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CancelBookingView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CancelBookingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
