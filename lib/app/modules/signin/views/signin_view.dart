import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign in'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SigninView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
