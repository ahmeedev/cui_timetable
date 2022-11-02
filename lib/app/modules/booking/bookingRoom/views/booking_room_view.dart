import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_room_controller.dart';

class BookingRoomView extends GetView<BookingRoomController> {
  const BookingRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingRoomView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BookingRoomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
