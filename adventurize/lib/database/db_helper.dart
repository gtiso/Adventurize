import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db_tables.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/database/demo_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> _initDatabase() async {
    String? dbPath;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final databasePath = await getDatabasesPath();
    dbPath = join(databasePath, "adventurize.db");

    return openDatabase(dbPath!, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(challenges);
    });
  }

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<bool> auth(Users usr) async {
    final Database db = await getDatabase();
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE email = ? AND password = ?",
      [usr.email, usr.password],
    );
    print(result);
    return result.isNotEmpty;
  }

  Future<Users?> getUsr(String email) async {
    final Database db = await getDatabase();
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<int> createUsr(Users usr) async {
    final Database db = await getDatabase();
    int userId = await db.insert("users", usr.toMap());
    return userId;
  }

  Future<void> insChall(Challenge chall) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> existingChallenges = await db.query(
      'challenges',
      where: 'title = ? AND desc = ?',
      whereArgs: [chall.title, chall.desc],
    );

    if (existingChallenges.isEmpty) {
      await db.insert('challenges', chall.toMap());
    }
  }

  Future<List<Challenge>> getChalls() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('challenges');
    return List.generate(maps.length, (i) {
      return Challenge(
        challengeID: maps[i]['challengeId'],
        title: maps[i]['title'],
        desc: maps[i]['desc'],
        photoPath: maps[i]['photoPath'],
        points: maps[i]['points'],
        shared: maps[i]['shared'],
      );
    });
  }

  Future<void> insDemoData() async {
    await insData();
  }
}
