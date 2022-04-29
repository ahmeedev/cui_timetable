import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TeacherUIController extends GetxController {
  var teachers;
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  @override
  Future<void> onInit() async {
    await fetchTeachers();
    var string = '';

    final box = await Hive.openBox('info');
    try {
      var value = box.get("search_teacher");
      if (value.isNotEmpty) {
        string = value.toString();
      }
      print('Search_Teacher Added: $value');
    } catch (e) {
      print(e);
    }

    textController.text = string;

    super.onInit();
  }

  Future<void> fetchTeachers() async {
    final box = await Hive.openBox('info');
    final list = box.get('teachers');
    teachers = list;
    print('teachers are $teachers');
  }
}
