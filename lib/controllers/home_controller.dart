import 'package:intl/intl.dart';
import 'package:smart_routine/models/task.dart';
import 'package:smart_routine/models/taskEvent.dart';
import 'package:smart_routine/providers/database_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  final Rx<List<Task>> _myTasks = Rx<List<Task>>([]);
  final Rx<List<TaskEvent>> _myTaskEvents = Rx<List<TaskEvent>>([]);

  List<Task> get myTasks => _myTasks.value;
  List<TaskEvent> get myTaskEvents => _myTaskEvents.value;

  final DateFormat _formatter = DateFormat('MM/dd/yyyy');

  @override
  void onInit() {
    super.onInit();
    getTasks();
    getTaskEvents();
  }

  getTasks() async {
    _myTasks.value = await DatabaseProvider.getTasks();
  }

  getTaskEvents() async {
    _myTaskEvents.value = await DatabaseProvider.getTaskEvents();
  }

  reloadTasks() {
    _myTasks.value = List.from(_myTasks.value);
  }

  Future<int> deleteTask(String id) async {
    return await DatabaseProvider.deleteTask(id);
  }

  Future<int> failTask(int? taskId) async {
    return await DatabaseProvider.completeOrFailTask(
        false, _formatter.format(_selectedDate.value), taskId);
  }

  Future<int> completeTask(int? taskId) async {
    return await DatabaseProvider.completeOrFailTask(
        true, _formatter.format(_selectedDate.value), taskId);
  }

  bool isTaskCompletedThisDate(Task task) {
    print("selected date $_selectedDate");
    List<TaskEvent> selectedDateEvents = List.from(myTaskEvents);
    for (var i = selectedDateEvents.length - 1; i >= 0; i--) {
      if (selectedDateEvents[i].date != _formatter.format(_selectedDate.value))
        selectedDateEvents.removeAt(i);
    }
    int count = selectedDateEvents.length;
    print("events for this date: $count");
    for (var i = 0; i < selectedDateEvents.length; i++) {
      if (task.id == selectedDateEvents[i].taskId &&
          selectedDateEvents[i].type == 0) return true;
    }
    print("task is completed this date: false");
    return false;
  }

  bool isTaskFailedThisDate(Task task) {
    List<TaskEvent> selectedDateEvents = List.from(myTaskEvents);
    for (var i = selectedDateEvents.length - 1; i >= 0; i--) {
      if (selectedDateEvents[i].date != _formatter.format(_selectedDate.value))
        selectedDateEvents.removeAt(i);
    }
    int count = selectedDateEvents.length;
    print("events for this date: $count");
    for (var i = 0; i < selectedDateEvents.length; i++) {
      if (task.id == selectedDateEvents[i].taskId &&
          selectedDateEvents[i].type == 1) return true;
    }
    print("task is failed this date: false");
    return false;
  }

/*
  Future<int> upDateCompleted(String id, String dateCompleted) async {
    return await DatabaseProvider.updateDateCompleted(id, dateCompleted);
  }

  Future<int> upDateOmitted(String id, String dateOmitted) async {
    return await DatabaseProvider.updateDateOmitted(id, dateOmitted);
  }*/

  updateSelectedDate(DateTime date) {
    _selectedDate.value = date;
    getTasks();
    getTaskEvents();
  }
}
