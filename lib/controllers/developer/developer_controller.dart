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
    String path = join(databasesPath, 'cui.db');
// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE timetable (section text,subject text,slot text,day text,teacher text,room text )');
    });
    this.database = database;
    print('Database created');
    super.onInit();
  }

  Future<void> insertData() async {
    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          "INSERT INTO timetable VALUES('some name','2','3','4','5','6')");
      print('Row Inserted: $id1');
    });
  }

  Future<void> retreiveData() async {
    // Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM testing');
    data.value = list;
  }

  deleteData() async {
    int count = await database.rawDelete('DELETE FROM testing');
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 1),
      title: 'Databae',
      message: '$count',
    ));
  }
}
