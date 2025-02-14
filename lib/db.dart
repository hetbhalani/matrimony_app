import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

List<Map<String, dynamic>> users = [];


class MatrimonyDB{
  Future<Database> initDatabase() async {
    Database db1 = await openDatabase(
        join(await getDatabasesPath(), 'users.db'),
        version: 1,
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,phone TEXT,dob TEXT,city TEXT,gender INTEGER,hobbies TEXT, isFav INTEGER)"
      );
    });
    return db1;
  }

  Future<void> addUser(String name, String email, String phone, String dob, String city, bool gender,List<String> hobbies, bool isFav) async {
    Database db1 = await initDatabase();
    await db1.insert('USER', {'name': name, 'email': email, 'phone': phone, 'dob': dob, 'city': city, 'gender': gender ? 1 : 0,'hobbies': hobbies.join(','), 'isFav': isFav ? 1 : 0});
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> users = await db.query('USER');

    return users.map((user) => {
      'id': user['id'],
      'name': user['name'],
      'email': user['email'],
      'phone': user['phone'],
      'dob': user['dob'],
      'city': user['city'],
      'gender': user['gender'] == 1,
      'hobbies': (user['hobbies'] as String).split(','),
      'isFav': user['isFav'] == 1,
    }).toList();
  }
}