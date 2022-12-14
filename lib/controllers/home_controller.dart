import 'package:smart_routine/models/task.dart';
import 'package:smart_routine/providers/database_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  final Rx<List<Task>> _myTasks = Rx<List<Task>>([]);

  List<Task> get myTasks => _myTasks.value;

  @override
  void onInit() {
    super.onInit();
    getTasks();
  }

  getTasks() async {
    final List<Task> tasksFromDB = [];
    List<Map<String, dynamic>> tasks = await DatabaseProvider.queryTasks();
    tasksFromDB.assignAll(
        tasks.reversed.map((data) => Task().fromJson(data)).toList());
    _myTasks.value = tasksFromDB;
    for (var i = tasks.length - 1; i >= 0; i--) {
      if (myTasks[i].isCompleted == 1 || myTasks[i].failed == 1) {
        myTasks.removeAt(i);
      }
    }
  }

  Future<int> deleteTask(String id) async {
    return await DatabaseProvider.deleteTask(id);
  }

  Future<int> failTask(String id) async {
    return await DatabaseProvider.failTask(id);
  }

  Future<int> upDateTask(String id) async {
    return await DatabaseProvider.updateTask(id);
  }

  updateSelectedDate(DateTime date) {
    _selectedDate.value = date;
    getTasks();
  }
}
