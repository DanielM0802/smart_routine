import 'dart:ffi';

import 'package:smart_routine/models/task.dart';
import 'package:smart_routine/models/taskStats.dart';
import 'package:smart_routine/providers/database_provider.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  final Rx<List<Task>> _myTasks = Rx<List<Task>>([]);
  List<Task> get myTasks => _myTasks.value;

  TaskStats myStats = TaskStats();

  getTasks() async {
    final List<Task> tasksFromDB = [];
    List<Map<String, dynamic>> tasks = await DatabaseProvider.queryTasks();
    tasksFromDB.assignAll(
        tasks.reversed.map((data) => Task().fromJson(data)).toList());
    _myTasks.value = tasksFromDB;
  }

  Future<TaskStats> GetStats() async {
    await getTasks();
    TaskStats result = TaskStats();
    for (var i = 0; i < myTasks.length; i++) {
      if (myTasks[i].isCompleted == 1) result.completed++;
      if (myTasks[i].failed == 1) result.failed++;
    }
    result.count = myTasks.length;
    result.completedPercent =
        (result.completed.toDouble() / myTasks.length.toDouble()) * 100;

    myStats = result;
    return result;
  }
}
