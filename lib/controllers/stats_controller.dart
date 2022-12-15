import 'dart:ffi';

import 'package:smart_routine/models/task.dart';
import 'package:smart_routine/models/taskEvent.dart';
import 'package:smart_routine/models/taskStats.dart';
import 'package:smart_routine/providers/database_provider.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  final Rx<List<TaskEvent>> _myEvents = Rx<List<TaskEvent>>([]);
  List<TaskEvent> get myEvents => _myEvents.value;

  TaskStats myStats = TaskStats();

  getEvents() async {
    _myEvents.value = await DatabaseProvider.getTaskEvents();
  }

  Future<TaskStats> GetStats() async {
    TaskStats result = TaskStats();
    getEvents();
    List<Task> tasks = await DatabaseProvider.getTasks();

    List<TaskEvent> sortedEvents = List.from(myEvents);
    sortedEvents.sort((a, b) {
      return a.date!.compareTo(b.date!);
    });

    int currentBest = 0;
    int best = 0;
    int currentCount = 0;
    for (var i = 0; i < sortedEvents.length; i++) {
      if (sortedEvents[i].type == 0) {
        result.completed++;
        currentCount++;
        if (i == sortedEvents.length - 1) {
          if (currentCount > best) best = currentCount;
          currentBest = currentCount;
          break;
        }
      } else if (sortedEvents[i].type == 1) {
        result.failed++;
        if (currentCount > best) best = currentCount;
        currentBest = currentCount;
        currentCount = 0;
      }
    }
    result.count = tasks.length;
    result.completedPercent = result.count != 0
        ? 100 *
            (result.completed.toDouble() /
                (result.completed + result.failed).toDouble())
        : 0;
    result.bestScore = best;
    result.currentScore = currentBest;

    myStats = result;
    return result;
  }
}
