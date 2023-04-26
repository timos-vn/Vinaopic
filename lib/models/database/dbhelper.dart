import 'dart:core';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vinaoptic/core/untils/log.dart';
import 'package:vinaoptic/model/account.dart';

class DatabaseHelper {
  static const NEW_DB_VERSION = 3; // current 12
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await init();
    return _database!;
  }

  void _onCreate(Database db, int version) {


    db.execute('''
    CREATE TABLE AccountSave(
      userName TEXT,
      pass TEXT,
      codeUnit TEXT,
      nameUnit TEXT,
      codeStore TEXT,
      nameStore TEXT)
  ''');
    print("Database AccountSave was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
    logger.i(
      "Migration: $oldVersion, $newVersion",
    );
    if (oldVersion == 1 && newVersion == 2) {
      db.execute('ALTER TABLE AccountSave ADD COLUMN attributes TEXT');
      db.delete("AccountSave");
    }
    db.execute('DROP TABLE IF EXISTS AccountSave');
    db.delete("AccountSave");
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = p.join(directory.toString(), 'database.db');
    var database = await openDatabase(dbPath);
    // var shouldCreate = false;
    // var database = await openDatabase(dbPath, version: 2, onCreate: _onCreate,
    //     onUpgrade: (db, oldVersion, newVersion) {
    //       if (oldVersion < 2) {
    //         // Need to recreate the db
    //         shouldCreate = true;
    //       }
    //     });
    // if (shouldCreate) {
    //   await database.close();
    //   await deleteDatabase(dbPath);
    //   database = await openDatabase(dbPath, version: 2, onCreate: _onCreate);
    // }

    if (await database.getVersion() < NEW_DB_VERSION) {

      print('check version db < ');
      database.close();
      await deleteDatabase(dbPath);

      //database = await openDatabase(dbPath, version: NEW_DB_VERSION, onCreate: _onCreate);
      database = await openDatabase(dbPath,onCreate: _onCreate,version: NEW_DB_VERSION);
      database.setVersion(NEW_DB_VERSION);
    }else{
      print('check version db ==');
      database = await openDatabase(dbPath,onCreate: _onCreate, onUpgrade: _onUpgrade,version: NEW_DB_VERSION);
    }

    // _onUpgrade(db, oldVersion, newVersion);
    // var database = openDatabase(dbPath, version: 2,
    //     onCreate: (db, version)async{
    //   _onCreate(db,version);
    // },
    //     onUpgrade:(Database db, int _, int __)async{
    //   _onUpgrade(db,_,__);
    // });
    return database;
  }

  /// Account
  Future<void> saveAccount(AccountInfo accountInfo) async {
    var client = await db;
    AccountInfo? oldAccountInfo = await fetchAccountInfo(accountInfo.userName);
    if (oldAccountInfo == null)
      await client.insert('AccountSave', accountInfo.toMapForDb(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    else {
      await updateAccountInfo(oldAccountInfo);
    }
  }

  Future<int> updateAccountInfo(AccountInfo accountInfo) async {
    var client = await db;
    return client.update('AccountSave', accountInfo.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<AccountInfo?> fetchAccountInfo(String userName,) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('AccountSave', where: 'userName = ?', whereArgs: [userName]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return AccountInfo.fromDb(maps.first);
    }
    return null;
  }

  Future<List<AccountInfo>> fetchAllAccountInfo() async {
    var client = await db;
    var res = await client.query('AccountSave');

    if (res.isNotEmpty) {
      var accountInfo =
      res.map((productMap) => AccountInfo.fromDb(productMap)).toList();
      return accountInfo;
    }
    return [];
  }
}
