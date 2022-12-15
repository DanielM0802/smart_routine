import 'package:flutter/cupertino.dart';
import 'package:smart_routine/constants/colors.dart';
import 'package:smart_routine/models/task.dart';
import 'package:get/get.dart';
import 'package:smart_routine/models/taskEvent.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database? _db;
  static final int _version = 1;
  static final String _tableTasksName = 'tasks';
  static final String _tableEventsName = 'taskEvents';
  static final String _path = 'tasks.db';

  DatabaseProvider();

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + _path;
      _db = await openDatabase(path,
          version: _version,
          onCreate: (db, version) => populateDb(db, version));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error initializing database',
        backgroundColor: Color(0xFF212121),
        colorText: pinkClr,
      );
    }
  }

  static void populateDb(Database database, int version) async {
    await database.execute('''
         CREATE TABLE $_tableTasksName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title STRING, date STRING, startTime STRING, endTime STRING,
          repeat STRING, color INTEGER)
        ''');
    await database.execute('''
          CREATE TABLE $_tableEventsName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type INTEGER, date STRING, taskId INTEGER);
        ''');
  }

  static Future<List<Map<String, dynamic>>> queryTasks() async {
    return await _db!.query(_tableTasksName);
  }

  static Future<List<Map<String, dynamic>>> queryTaskEvents() async {
    return await _db!.query(_tableEventsName);
  }

  static Future<int> insertTask(Task task) async {
    return await _db!.insert(_tableTasksName, task.toMap());
  }

  static Future<int> deleteTask(String id) async {
    return await _db!.delete(_tableTasksName, where: 'id=?', whereArgs: [id]);
  }

/*
  static Future<int> updateTask(String id) async {
    return await _db!.rawUpdate('''
UPDATE $_tableTasksName 
SET isCompleted = ?
WHERE id = ? 
''', [1, id]);
  }*/

  static Future<int> completeOrFailTask(
      bool completed, String date, int? taskId) async {
    TaskEvent event = TaskEvent();
    event.type = completed ? 0 : 1;
    event.date = date;
    event.taskId = taskId;
    print("added event $completed for date $date");
    return await _db!.insert(_tableEventsName, event.toMap());
  }

  static Future<List<Task>> getTasks() async {
    final List<Task> tasksFromDB = [];
    List<Map<String, dynamic>> tasks = await queryTasks();
    tasksFromDB.assignAll(
        tasks.reversed.map((data) => Task().fromJson(data)).toList());
    return tasksFromDB;
  }

  static Future<List<TaskEvent>> getTaskEvents() async {
    final List<TaskEvent> eventsFromDB = [];
    List<Map<String, dynamic>> events = await queryTaskEvents();
    eventsFromDB.assignAll(
        events.reversed.map((data) => TaskEvent().fromJson(data)).toList());
    return eventsFromDB;
  }

  static Future<Task?> getTaskById(String id) async {
    final List<Task> tasksFromDB = await getTasks();
    for (var i = 0; i < tasksFromDB.length; i++) {
      if (tasksFromDB[i].id == id) return tasksFromDB[i];
    }
    return null;
  }

/*
  static Future<int> updateDateCompleted(
      String id, String dateCompleted) async {
    return await _db!.rawUpdate('''
UPDATE $_tableTasksName 
SET dateCompleted = ?
WHERE id = ? 
''', [dateCompleted, id]);
  }

  static Future<int> updateDateOmitted(String id, String dateOmitted) async {
    return await _db!.rawUpdate('''
UPDATE $_tableName 
SET dateOmitted = ?
WHERE id = ? 
''', [dateOmitted, id]);
  }

  static Future<int> failTask(String id) async {
    return await _db!.rawUpdate('''
UPDATE $_tableName 
SET failed = ?
WHERE id = ? 
''', [1, id]);
  }*/

}
