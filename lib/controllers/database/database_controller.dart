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

    final box = await Hive.openBox("info");
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
    await _updateStatuses(remoteVersion);
    await Future.delayed(const Duration(seconds: 1));
    Hive.close();
    return Future<int>.value(1);
  }

  deleteData() async {
    var box = await Hive.openBox('info');
    var sections = box.get('sections');
    for (var i in sections) {
      await Hive.openBox(i);
    }
    Hive.deleteFromDisk();
  }

  Future<void> _updateStatuses(remoteVersion) async {
    final box = await Hive.openBox('info');
    box.put('version', remoteVersion);
    print('box with value $remoteVersion');

    print('Server:  $remoteVersion');
    print('Box: ${box.get('version')}');
  }
}
