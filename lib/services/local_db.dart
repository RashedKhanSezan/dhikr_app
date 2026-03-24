import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dhikr_app/models/dhikr_model.dart';

class LocalDb {
  static final LocalDb instance = LocalDb._init();
  static Database? _database;

  LocalDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dhikr.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE dhikr (
      id INTEGER PRIMARY KEY,
      count INTEGER,
      totalSubhanAllah INTEGER,
      totalAlhamdulillah INTEGER,
      totalAllahuAkbar INTEGER,
      sessionsCompleted INTEGER,
      isSoundOn INTEGER,
      isVibrationOn INTEGER
    )
    ''');
   
    await db.insert('dhikr', {
      'id': 1,
      'count': 0,
      'totalSubhanAllah': 0,
      'totalAlhamdulillah': 0,
      'totalAllahuAkbar': 0,
      'sessionsCompleted': 0,
      'isSoundOn': 1,
      'isVibrationOn': 1,
    });
  }

  Future<void> updateDhikr(DhikrModel model) async {
    final db = await instance.database;
    await db.update(
      'dhikr',
      {
        'count': model.count,
        'totalSubhanAllah': model.totalSubhanAllah,
        'totalAlhamdulillah': model.totalAlhamdulillah,
        'totalAllahuAkbar': model.totalAllahuAkbar,
        'sessionsCompleted': model.sessionsCompleted,
        'isSoundOn': model.isSoundOn ? 1 : 0,
        'isVibrationOn': model.isVibrationOn ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<Map<String, dynamic>?> getDhikr() async {
    final db = await instance.database;
    final maps = await db.query('dhikr', where: 'id = ?', whereArgs: [1]);
    if (maps.isNotEmpty) return maps.first;
    return null;
  }
}