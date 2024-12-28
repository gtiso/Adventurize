import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db_tables.dart';
import 'package:adventurize/models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> _initDatabase() async {
    String? dbPath;
    sqfliteFfiInit(); // Initialize the database factory
    databaseFactory = databaseFactoryFfi; //Set the database factory to useFFI
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

  Future<bool> authenticate(Users usr) async {
    final Database db = await getDatabase();
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE email = ? AND password = ?",
      [usr.email, usr.password],
    );
    print(result);
    return result.isNotEmpty;
  }

  Future<Users?> getUser(String email) async {
    final Database db = await getDatabase();
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    //insertData();
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<int> createUser(Users usr) async {
    final Database db = await getDatabase();
    int userId = await db.insert("users", usr.toMap());
    return userId;
  }
}
