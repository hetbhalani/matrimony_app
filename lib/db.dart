import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  Future<void> addUser(String name, String email, String phone, String dob, String city, String gender,List<String> hobbies, int isFav) async {
    Database db1 = await initDatabase();
    await db1.insert('USER', {'name': name, 'email': email, 'phone': phone, 'dob': dob, 'city': city, 'gender': gender,'hobbies': hobbies.join(','), 'isFav': isFav});
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
      'gender': user['gender'],
      'hobbies': (user['hobbies'] as String).split(','),
      'isFav': user['isFav'],
    }).toList();
  }

  Future<void> deleteUser(int id) async {
    final db = await initDatabase();
    await db.delete(
      'USER',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateUser({
    required int id,
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? city,
    String? gender,
    List<String>? hobbies,
    int? isFav,
  }) async {
    final db = await initDatabase();

    final Map<String, dynamic> updates = {};
    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;
    if (phone != null) updates['phone'] = phone;
    if (dob != null) updates['dob'] = dob;
    if (city != null) updates['city'] = city;
    if (gender != null) updates['gender'] = gender;
    if (hobbies != null) updates['hobbies'] = hobbies.join(',');
    if (isFav != null) updates['isFav'] = isFav;

    await db.update(
      'USER',
      updates,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getFavUsers() async {
    final db = await initDatabase();
    return await db.query('users', where: 'isFav = ?', whereArgs: [1]);
  }
}