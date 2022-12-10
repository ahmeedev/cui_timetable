import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contributions_controller.dart';

class ContributionsView extends GetView<ContributionsController> {
  const ContributionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text('ContributionsView'),
          centerTitle: true,
        ),
        body: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Center(
                      child: Text(
                    "Meet our team of developers",
                    style: textTheme.titleLarge!.copyWith(color: Colors.black),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
