import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/controllers/database/database_utilities.dart';
import 'package:cui_timetable/views/utilities/loc_utilities.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

class TimetableDatabaseController extends GetxController {
  // String search_section = '';

  createDatabase() async {
    await downloadFile(
        fileName: 'timetable.csv', callback: insertTimetableData);
  }

  //! All the code run in working Isolate, Be aware

  Future<Future<int>> insertTimetableData(
      {required String filePath, required List<dynamic> data}) async {
    Hive.init(filePath); // initialize the data, bcz of their separate isolate.
    print('Filepath is:   $filePath');
    // fetch sections as well as teachers.
    final sections = <String>{};
    final teachers = <String>{};

    for (var item in data) {
      sections.add(item[0]);
      teachers.add(item[4]);
    }

    //  =====  creating students database  ===== //
    final box1 = await Hive.openBox("studentsDB");

    for (var i in sections) {
      var lectures = data
          .toList()
          .where((element) =>
              element[0].toString().toLowerCase() == i.toLowerCase())
          .toList();
      box1.put(i.toLowerCase(), lectures);
    }
    // await Future.delayed(const Duration(milliseconds:500));
    // await box1.close();

    //  =====  creating teachers database  ===== //
    final box2 = await Hive.openBox("teachersDB");

    for (var i in teachers) {
      var lectures = data
          .toList()
          .where((element) =>
              element[4].toString().toLowerCase() == i.toLowerCase())
          .toList();
      box2.put(i.toLowerCase(), lectures);
    }
    // await Future.delayed(const Duration(milliseconds:500));

    // await box2.close();

    //  =====  storing  students and teachers list  ===== //
    final box3 = await Hive.openBox("info");
    box3.put("sections", sections.toList());
    box3.put("teachers", teachers.toList());
    print(box3.values);
    // await _insertTime();
    // await _updateStatuses(remoteVersion);
    await Future.delayed(const Duration(seconds: 1));
    Hive.close();
    return Future<int>.value(1);
  }

  Future<void> insertTime() async {
    final box = await Hive.openBox('timeSlots');

    var collection = FirebaseFirestore.instance.collection('info');
    var docSnapshot = await collection.doc('time').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      final time1 = data?['monToThur'];
      final time2 = data?['fri'];
      box.put('monToThur', time1);
      box.put('fri', time2);
    } else {
      final time = {
        "1": "08:00AM - 10:00AM",
        "2": "10:00AM - 11:30AM",
        "3": "11:30AM - 01:00PM",
        "4": "01:30PM - 03:00PM",
        "5": "03:00PM - 04:30PM",
      };
      box.put('time', time);
    }

    print(box.get('monToThur'));
    print(box.get('fri'));
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
