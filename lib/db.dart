import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EmpData {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
                        CREATE TABLE IF NOT EXISTS employees( 
                        id int primary key,
                        name varchar(255) not null,
                        employee_id int not null,
                        address varchar(255) not null,
                        experience int)
                      ''');
    });
  }

  Future<Map<dynamic, dynamic>?> getEmployee(int employeeid) async {
    List<Map> maps = await db
        .query('Employees', where: 'employee_id = ?', whereArgs: [employeeid]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
