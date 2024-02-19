import 'lecture.dart';

class LectureSlot {
  final int? id;
  final Lecture? lecture;
  final String? name;
  final int day;
  final double timeFrom;
  final double timeTo;
  final String? hexColor;

  LectureSlot({
    this.id,
    this.lecture,
    this.name,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    this.hexColor,
  });

  factory LectureSlot.fromJson(Map<String, dynamic> json) {
    return LectureSlot(
      id: json['id'],
      lecture: json['lecture'] != null ? Lecture.fromJson(json['lecture']) : null,
      name: json['name'],
      day: json['day'],
      timeFrom: double.parse(json['timeFrom'].substring(0, 2)),
      timeTo: double.parse(json['timeTo'].substring(0, 2))+1,
      hexColor: json['hexColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lecture': lecture != null ? lecture!.toJson() : null,
      'name': name,
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'hexColor': hexColor,
    };
  }
}
