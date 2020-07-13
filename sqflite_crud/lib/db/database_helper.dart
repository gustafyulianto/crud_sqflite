import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_crud/model/sqluser_model.dart';

class db_sqflite {
  static final db_sqflite _instance = db_sqflite._internal();
  static Database _database;

  final String tableName = 'tableUser';
  final String columnId = 'id';
  final String columnUser = 'User';
  final String columnPassword = 'Password';

  db_sqflite._internal();
  factory db_sqflite() => _instance;

  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'User.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE  $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnUser TEXT,"
        "$columnPassword TEXT)";
    await db.execute(sql);
  }

  Future<int> saveUser(UserLogin user) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName, user.toMap());
  }

  Future<List> getAllUser() async {
    var dbClient = await _db;
    var result = await dbClient
        .query(tableName, columns: [columnId, columnUser, columnPassword]);
    /*result = result
      ..forEach((element) {
        var a = element.values.toList();
        print('data $a');
        return a;
      });*/
    return result.toList();
  }

  Future<int> updateUser(UserLogin user) async {
    var dbClient = await _db;
    return await dbClient.update(tableName, user.toMap(),
        where: '$columnId=?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await _db;
    return await dbClient
        .delete(tableName, where: '$columnId=?', whereArgs: [id]);
  }

  Future<List> User(User, Password) async {
    var dbClient = await _db;
    var sql =
        "SELECT * FROM $tableName WHERE User = '$User' and Password = '$Password'";
    var result = await dbClient.rawQuery(sql);
    return result.toList();
  }
}
