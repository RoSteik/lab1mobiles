import 'package:my_project/lab2/logic/model/fitness_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'FitnessApp.db';
  static const _databaseVersion = 1;
  static const table = 'fitness_data';

  static const columnId = 'id';
  static const columnSteps = 'steps';
  static const columnCaloriesBurned = 'caloriesBurned';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate,);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnSteps TEXT NOT NULL,
            $columnCaloriesBurned TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(FitnessData data) async {
    final Database db = await database;
    return await db.insert(table, data.toJson());
  }

  Future<List<FitnessData>> queryAllRows() async {
    final Database db = await database;
    final res = await db.query(table);
    return res.isNotEmpty ? res.map(FitnessData.fromJson).toList() : [];
  }

  Future<int> delete(int id) async {
    final Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    final db = await database;
    await db.delete(table);
  }

}
