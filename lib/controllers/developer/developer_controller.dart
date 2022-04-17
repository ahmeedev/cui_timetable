import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DeveloperController extends GetxController {
  late final database;
  var data = [].obs;

  @override
  Future<void> onInit() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER, name TEXT, value INTEGER, num REAL)');
    });
    this.database = database;
    print('done');
    super.onInit();
  }

  Future<void> insertData() async {
    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
          ['another name', 12345678, 3.1416]);
      print('inserted2: $id2');
    });
  }

  Future<void> retreiveData() async {
    // Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    data.value = list;
  }

  deleteData() async {
    int count = await database.rawDelete('DELETE FROM Test');
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 1),
      title: 'Databae',
      message: '$count',
    ));
  }
}
