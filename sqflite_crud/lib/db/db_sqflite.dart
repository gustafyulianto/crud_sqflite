import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_crud/model/mahasiswa.dart';

class db_sqflite {
  static final db_sqflite _instance = db_sqflite._internal();
  static Database _database;

  final String tableName = 'tableMahasiswa';
  final String columnId = 'id';
  final String columnName = 'Name';
  final String columnBirthPlace = 'BirthPlace';
  final String columnGender = 'Gender';
  final String columnReligion = 'Religion';
  final String columnRegEmail = 'RegEmail';
  final String columnHpNumber = 'HpNumber';

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
    String path = join(databasePath, 'Mahasiswa.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE  $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnBirthPlace TEXT,"
        "$columnGender TEXT,"
        "$columnReligion TEXT,"
        "$columnRegEmail TEXT,"
        "$columnHpNumber TEXT)";
    await db.execute(sql);
  }

  Future<int> saveMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName, mahasiswa.toMap());
  }

  Future<List> getAllMahasiswa() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName, columns: [
      columnId,
      columnName,
      columnBirthPlace,
      columnGender,
      columnReligion,
      columnRegEmail,
      columnHpNumber
    ]);
    /*result = result
      ..forEach((element) {
        var a = element.values.toList();
        print('data $a');
        return a;
      });*/
    return result.toList();
  }

  Future<int> updateMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient.update(tableName, mahasiswa.toMap(),
        where: '$columnId=?', whereArgs: [mahasiswa.id]);
  }

  Future<int> deleteMahasiswa(int id) async {
    var dbClient = await _db;
    return await dbClient
        .delete(tableName, where: '$columnId=?', whereArgs: [id]);
  }
}
