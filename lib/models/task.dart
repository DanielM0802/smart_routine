class Task {
  int? id;
  String? title;
  String? repeat;
  String? date;
  String? startTime;
  String? endTime;
  int? color;

  Task({
    this.id,
    this.title,
    this.repeat,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
  });

  Task fromJson(Map<String, dynamic> json) => Task(
      id: json['id'],
      title: json['title'],
      repeat: json['repeat'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      color: json['color']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'repeat': repeat,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'color': color,
      };

  void showInfo() => {print("$title")};
}
