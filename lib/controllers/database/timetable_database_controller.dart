import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

class TimetableDatabaseController extends GetxController {
  // String search_section = '';

  Future<Future<int>> insertDataOfTimetable(
      List<dynamic> data, remoteVersion) async {
    // fetch sections as well as teachers.
    final sections = <String>{};
    final teachers = <String>{};

    for (var item in data) {
      sections.add(item[0]);
      teachers.add(item[4]);
    }

    final box = await Hive.openBox("info");
    box.put("sections", sections.toList());
    box.put("teachers", teachers.toList());

    // opening all the boxes for students and teachers.
    int counter = 0;
    for (var i in sections) {
      await Hive.openBox(i);
      // print('$i created $counter');
      // counter++;
    }
    counter = 0;
    for (var i in teachers) {
      await Hive.openBox(i);
      // print('$i created $counter');
      // counter++;
    }

    // insert data for students as well as for students.
    counter = 0;
    for (var i in data) {
      final student = Hive.box(i[0].toString());
      final teacher = Hive.box(i[4].toString());
      student.put('lec$counter', [
        i[1].toString(),
        i[2].toString(),
        i[3].toString(),
        i[4].toString(),
        i[5].toString()
      ]);

      teacher.put('lec$counter', [
        i[0].toString(),
        i[1].toString(),
        i[2].toString(),
        i[3].toString(),
        i[5].toString()
      ]);

      counter++;
    }

    // print('Sections Length: ${sections.length}');
    // print('Teachers Length: ${teachers.length}');

    await _insertTime();
    await _updateStatuses(remoteVersion);
    await Future.delayed(const Duration(seconds: 1));
    Hive.close();
    return Future<int>.value(1);
  }

  Future<void> _insertTime() async {
    final box = await Hive.openBox('info');

    var collection = FirebaseFirestore.instance.collection('info');
    var docSnapshot = await collection.doc('time').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      final time = data?['all'];
      box.put('time', time);
    } else {
      final time = {
        "1": "08:00AM - 10:00AM",
        "2": "10:00AM - 11:30AM",
        "3": "11:30AM - 01:00PM",
        "4": "01:30PM - 3:00PM",
        "5": "03:00PM - 04:30PM"
      };
      box.put('time', time);
    }

    // print(box.get('time'));
  }

  Future<void> deleteData() async {
    var box = await Hive.openBox('info');
    try {
      var sections = box.get('sections');
      for (var i in sections) {
        // final box = await Hive.openBox(i);
        Hive.deleteBoxFromDisk(i);
      }
      var teachers = box.get('teachers');
      for (var i in teachers) {
        Hive.deleteBoxFromDisk(i);
      }
    } catch (e) {
      print(e);
    } finally {
      // Hive.deleteFromDisk();
      box.deleteAll(['sections', 'teachers']);
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    // print('Data deleted From Disk Succuessfully');
    // preserve the values
  }

  Future<void> _updateStatuses(remoteVersion) async {
    final box = await Hive.openBox('info');
    box.put('version', remoteVersion);
    box.put('last_update', Jiffy().format("MMMM do yyyy"));
    // box.put('search_section', search_section);
    // print('box with value $remoteVersion');

    // print('Server:  $remoteVersion');
    // print('Box: ${box.get('version')}');
  }
}
