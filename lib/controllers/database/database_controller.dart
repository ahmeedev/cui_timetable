import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends GetxController {
  Future<Future<int>> insertData(List<dynamic> data, remoteVersion) async {
    final sections = <String>{};
    for (var item in data) {
      sections.add(item[0]);
    }

    late final box;
    // try {
    box = await Hive.openBox("info");
    // } catch (e) {
    //   box = Hive.box('info');
    // }
    box.put("sections", sections.toList());

    print(box.get('sections'));

    int counter = 0;
    for (var i in sections) {
      await Hive.openBox(i);
      print('$i created $counter');
      counter++;
    }

    counter = 0;
    for (var i in data) {
      final storage = Hive.box(i[0].toString());
      storage.put('lec$counter', [
        i[1].toString(),
        i[2].toString(),
        i[3].toString(),
        i[4].toString(),
        i[5].toString()
      ]);
      print(i);
      counter++;
    }

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

    print(box.get('time'));
  }

  Future<void> deleteData() async {
    var box = await Hive.openBox('info');
    var sections = box.get('sections');
    try {
      for (var i in sections) {
        await Hive.openBox(i);
      }
    } catch (e) {
      print(e);
    } finally {
      Hive.deleteFromDisk();
    }
    await Future.delayed(const Duration(seconds: 1));
    print('Data deleted From Disk Succue');
  }

  Future<void> _updateStatuses(remoteVersion) async {
    final box = await Hive.openBox('info');
    box.put('version', remoteVersion);
    print('box with value $remoteVersion');

    print('Server:  $remoteVersion');
    print('Box: ${box.get('version')}');
  }
}
