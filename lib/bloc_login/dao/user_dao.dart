import 'package:tic_tac_toe/bloc_directory/database.dart';
import 'package:tic_tac_toe/bloc_login/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: "id = ?", whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<List<User>> myUsers() async {
    final db = await dbProvider.database;

    final List<Map<String, dynamic>> maps = await db.query('userTable');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        token: maps[i]['token']
      );
    });
  }
}
