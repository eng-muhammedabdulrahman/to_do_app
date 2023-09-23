// ignore_for_file: body_might_complete_normally_catch_error

import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';

class SqfliteHelper {
  late Database db;

  // 1. Create DB
  // 2. Create Table
  // 2. CRUD => create - read - update - delete

  //! initDatabase
  void initDB() async {
    // step 1 => create database
    await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int v) async {
        // step 2 => create table
        await db.execute('''
          CREATE TABLE Tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          notes TEXT,
          date TEXT,
          startTime TEXT,
          endTime TEXT,
          color INTEGER,
          isCompleted INTEGER
        )
        ''').then(
          (value) => print('DB created successfully'),
        );
      },
      onOpen: (db) => print('Database Opened'),
    ).then((value) => db = value).catchError((e) {
      print(e.toString());
    });
  }

  //! Get
  Future<List<Map<String, Object?>>> getFromDB() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  //! Insert
  Future<int> insertToDB(TaskModel model) async {
    return await db.rawInsert('''
      INSERT INTO Tasks(
      title, note, data, startTime, endTime, color, isCompleted,)
      VALUES
      (${model.title},${model.note},${model.data},${model.startTime},
      ${model.endTime},${model.color},${model.isCompleted},)
    ''');
  }

  //! Update
  Future<int> updateDB(int id) async {
    return await db.rawUpdate('''
    UPDATE Tasks
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }

//! Delete
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete(
      '''DELETE FROM Tasks WHERE id = ?''',
      [id],
    );
  }
}
