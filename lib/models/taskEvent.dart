class TaskEvent {
  int? id;
  int? type; //0 = completed, 1 = failed
  String? date;
  int? taskId;

  TaskEvent({this.id, this.date, this.type, this.taskId});

  TaskEvent fromJson(Map<String, dynamic> json) => TaskEvent(
      id: json['id'],
      type: json['type'],
      date: json['date'],
      taskId: json['taskId']);

  Map<String, dynamic> toMap() =>
      {'id': id, 'type': type, 'date': date, 'taskId': taskId};
}
