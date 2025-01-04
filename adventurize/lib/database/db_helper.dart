import 'dart:async';
import 'dart:io';
import 'package:adventurize/models/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'db_tables.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/database/demo_data.dart';

class DatabaseHelper {
  final dbName = 'adventurize.db';
  Database? db;

  Future<bool> dbExists(String path) async {
    return await File(path).exists();
  }

  Future<Database> getDB() async {
    if (db != null) {
      return db!;
    }
    db = await initDB();
    return db!;
  }

  Future<void> deleteExistingDB(String path) async {
    if (await databaseExists(path)) {
      await deleteDatabase(path);
    }
  }

  Future<Database> initDB() async {
    String? path;
    if (Platform.isAndroid || Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      // ignore: unused_local_variable
      path = join(directory.path, dbName);
    } else if (Platform.isLinux || Platform.isWindows) {
      // Only in Linux and Windows
      sqfliteFfiInit(); // Initialize the database factory
      databaseFactory = databaseFactoryFfi; //Set the database factory to useFFI
      final databasePath = await getDatabasesPath();
      // ignore: unused_local_variable
      path = join(databasePath, dbName);
    }
    // Βοηθητική συνάρτηση για να διαγράψουμε την βάση
    //await deleteExistingDatabase(path!);

    return openDatabase(path!, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(challenges);
      await db.execute(memories);
      await db.execute(userChallenges);
      await db.execute(userMemories);
    });
  }

  Future<bool> auth(User usr) async {
    final Database db = await getDB();
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE email = ? AND password = ?",
      [usr.email, usr.password],
    );
    print(result);
    return result.isNotEmpty;
  }

  Future<void> saveProfileToDB(User usr) async {
    final Database db = await getDB();
    int res = await db.rawUpdate(
      "UPDATE users SET fullname = ?, username = ?, birthdate = ?, password = ?, email = ? WHERE userID = ?",
      [
        usr.fullname,
        usr.username,
        usr.birthdate,
        usr.password,
        usr.email,
        usr.userID
      ],
    );
    debugPrint("Row Updation: $res");
  }

  Future<void> updateUserPoints(String email, int points) async {
    final Database db = await getDB();
    int res = await db.rawUpdate(
      "UPDATE users SET points = ? WHERE email = ?",
      [points, email],
    );
    debugPrint("Points updated for email $email: $res");
  }

  Future<void> updateChallengeShared(int challengeID, int shared) async {
    final Database db = await getDB();

    int res = await db.rawUpdate(
      "UPDATE challenges SET shared = ? WHERE challengeID = ?",
      [shared, challengeID],
    );

    debugPrint("Challenge shared updated for challengeID $challengeID: $res");
  }

  Future<User?> getUsr(String email) async {
    final Database db = await getDB();
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<String> getUserAvatar(int userID) async {
    final Database db = await getDB();
    var res = await db
        .rawQuery('SELECT avatarPath FROM users WHERE userID = ?', [userID]);
    return res.first.values.toString();
  }

  Future<String> getUsername(int userID) async {
    final Database db = await getDB();
    var res = await db
        .rawQuery('SELECT username FROM users WHERE userID = ?', [userID]);
    return res.first.values.toString();
  }

  Future<int> createUsr(User usr) async {
    final Database db = await getDB();
    int userID = await db.insert("users", usr.toMap());
    return userID;
  }

  Future<void> insUser(User user) async {
    final Database db = await getDB();
    List<Map<String, dynamic>> existingUser = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [user.email, user.password],
    );

    if (existingUser.isEmpty) {
      await db.insert('users', user.toMap());
    }
  }

  Future<void> insChall(Challenge chall) async {
    final Database db = await getDB();
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
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('challenges');
    return List.generate(maps.length, (i) {
      return Challenge(
        challengeID: maps[i]['challengeID'],
        title: maps[i]['title'],
        desc: maps[i]['desc'],
        photoPath: maps[i]['photoPath'],
        points: maps[i]['points'],
        shared: maps[i]['shared'],
      );
    });
  }

  Future<void> insMemory(Memory memory) async {
    final Database db = await getDB();
    List<Map<String, dynamic>> existingMemories = await db.query(
      'memories',
      where: 'title = ? AND description = ?',
      whereArgs: [memory.title, memory.description],
    );

    if (existingMemories.isEmpty) {
      await db.insert('memories', memory.toMap());
    }
  }

  Future<List<Memory>> getMemories() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('memories');
    return List.generate(maps.length, (i) {
      return Memory.fromMap(maps[i]);
    });
  }

  Future<List<Memory>> getMemoriesFromID(int? userID) async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'memories',
      where: 'userID = ?',
      whereArgs: [userID],
    );
    return List.generate(maps.length, (i) {
      return Memory.fromMap(maps[i]);
    });
  }

  Future<List<User>> getUsers() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        userID: maps[i]['userID'],
        fullname: maps[i]['fullname'],
        username: maps[i]['username'],
        email: maps[i]['email'],
        password: maps[i]['password'],
        birthdate: maps[i]['birthdate'],
        points: maps[i]['points'],
        avatarPath: maps[i]['avatarPath'],
      );
    });
  }

  Future<User?> getUsrFromEmail(String email) async {
    final Database db = await getDB();
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<void> insDemoData() async {
    await insData();
  }
}
