import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MatrimonyDB{

  List<Map<String, dynamic>> users = [];

  Future<Database> initDatabase() async {
    Database db1 = await openDatabase(
        join(await getDatabasesPath(), 'users.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER)",
      );
    });
    return db1;
  }

  Future<void> addUser(String name, int age) async {
    Database db1 = await initDatabase();
    await db1.insert('USER', {'name': name, 'age': age});
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    Database db = await initDatabase();
    return await db.query('USER');
  }
}