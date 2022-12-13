class Task {
  int? id;
  String? title;
  int? isCompleted;
  int? failed;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.color,
    this.date,
    this.endTime,
    this.isCompleted,
    this.failed,
    this.remind,
    this.repeat,
    this.startTime,
    this.title,
  });

  Task fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        isCompleted: json['isCompleted'],
        failed: json['failed'],
        remind: json['remind'],
        repeat: json['repeat'],
        startTime: json['startTime'],
        color: json['color'],
        endTime: json['endTime'],
        date: json['date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'failed': failed,
        'remind': remind,
        'repeat': repeat,
        'color': color,
        'endTime': endTime,
        'date': date,
        'startTime': startTime,
      };

  void showInfo() => {print("$title\n$repeat")};
}
