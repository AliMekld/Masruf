import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:masrof/core/LocalDataBase/sql_queries.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// this class is reponsible for creating tables and make local methods

class DatabaseHelper {
  //  singleTone
  DatabaseHelper._internal();
  static final DatabaseHelper _this = DatabaseHelper._internal();
  factory DatabaseHelper() => _this;

  ///=======================[constants]============================================//
  static const String _databaseName = "masruf.db";
  static const String expensesTable = "expensesTable";
  static const int _version = 1;
  bool get isWidowsOrLinux => Platform.isWindows || Platform.isLinux;

  /// get data base path

  static Database? _database;

  Future<Database> get database async {
    /// this method insures that the data base are initialed
    if (_database != null) _database;
    _database = await initDataBase();
    return _database!;
  }

  ///========================[init]==========================================///
  Future<Database> initDataBase() async {
    if (isWidowsOrLinux) {
      // Initialize FFI loader for Linux/Windows
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDir = await getApplicationDocumentsDirectory();
      final path = join(appDir.path, _databaseName);
      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: _version,
          onCreate: (db, version) => onCreateDataBase(db, version),
        ),
      );
    } else {
      String dataBasePath = await getDatabasesPath();

      String path = join(dataBasePath, _databaseName);
      debugPrint(
          "$database : Created SuccessFully version $_version from linux of Widows $isWidowsOrLinux");
      return await openDatabase(
        version: _version,
        path,
        onCreate: (database, version) => onCreateDataBase(database, version),
      );
    }
  }

  ///===============>> Create Database
  Future onCreateDataBase(Database database, int? version) async {
    /// create expenses table
    await database.execute(SqlQueries.createExpensesTable(expensesTable));
    debugPrint("$database : Created SuccessFully version $version");

    /// todo crate more tables in future
  }

  ///===============>> delete Database
  Future onDeleteeDataBase() async {
    if (_database != null && _database!.isOpen) await _database!.close();
    await deleteDatabase(_database!.path);
    print("$database delete");
  }

  ///===============>> Close Database
  Future onCloseDataBase() async {
    if (_database != null && _database!.isOpen) await _database!.close();
  }

  ///===============>>  insert Row in database
  Future<int> insert(
      {required Map<String, dynamic> model, required String tableName}) async {
    int response = 0;
    try {
      Database db = await database;
      response = await db.insert(tableName, model);
    } catch (e) {
      return 0;
    }
    return response;
  }

  ///===============>>  update Row database
  Future<int> update({
    required Map<String, dynamic> model,
    required String tableName,
    required String whereKey,
    required String whereValue,
  }) async {
    int response = 0;
    try {
      Database db = await database;
      bool containKey = model.containsKey(whereKey);
      response = await db.update(
        tableName,
        model,
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: containKey ? '$whereKey = ?' : null,
        whereArgs: containKey ? [model[whereKey]] : null,
      );
    } catch (e) {
      return 0;
    }
    return response;
  }

  ///===============>>  deltet From Row database
  Future<int> deleteFrom({
    required String tableName,
    required String whereKey,
    required int whereValue,
  }) async {
    int response = 0;
    try {
      Database db = await database;
      response = await db.delete(
        tableName,
        where: '$whereKey = ?',
        whereArgs: [whereValue],
      );
    } catch (e) {
      return 0;
    }
    return response;
  }

  /// ===============>> seleect From table  where
  Future<List<Map<String, dynamic>>> seleectFrom(
      {required String tableName}) async {
    try {
      Database db = await database;
      return await db.query(
        tableName,
      );
    } catch (e) {
      rethrow;
    }
  }

  ///========================>> onSearch item
  Future<Map<String, dynamic>> searchIn({
    required String tableName,
    required String whereKey,
    required int whereValue,
  }) async {
    List<Map<String, dynamic>> list;
    try {
      Database db = await database;
      list = await db.query(
        tableName,
        where: '$whereKey = ?',
        whereArgs: [whereValue],
        limit: 1,
      );
    } catch (e) {
      throw Exception(e);
    }
    return list.first;
  }
}
