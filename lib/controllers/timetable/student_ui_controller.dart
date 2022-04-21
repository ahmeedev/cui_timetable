import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentUIController extends GetxController {
  var sections;
  late final TextEditingController textController = TextEditingController();
  @override
  Future<void> onInit() async {
    await fetchSections();
    var string = '';

    final box = await Hive.openBox('info');
    var value = box.get("search_section");
    if (value.isNotEmpty) {
      string = value.toString();
    }
    print(string);
    print('value added');

    textController.text = string;

    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox('info');
    final list = box.get('sections');
    sections = list;
  }
}
