
import 'DatabaseHelper.dart';
import 'User.dart';

class UserRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toJson());
  }

  Future<List<User>> getAllUsers() async {
    final db = await dbHelper.database;
    final result = await db.query('users');
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await dbHelper.database;
    return await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
