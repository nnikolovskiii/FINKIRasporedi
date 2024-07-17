import 'lecture.dart';

class LectureSlot {
  final int? id;
  final Lecture? lecture;
  String? name;
  int day;
  int timeFrom;
  int timeTo;
  String? hexColor;
  String? abbreviation;

  LectureSlot({
    this.id,
    this.lecture,
    this.name,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    this.hexColor,
    this.abbreviation
  });

  factory LectureSlot.fromJson(Map<String, dynamic> json) {
    return LectureSlot(
      id: json['id'],
      lecture:
          json['lecture'] != null ? Lecture.fromJson(json['lecture']) : null,
      name: json['name'],
      day: json['day'],
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'] ,
      hexColor: json['hexColor'],
      abbreviation: json['abbreviation']
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
    };

    if (id != null) json['id'] = id;
    if (lecture != null) json['lecture'] = lecture!.toJson();
    if (name != null) json['name'] = name;
    if (hexColor != null) json['hexColor'] = hexColor;
    if (abbreviation != null) json['abbreviation'] = abbreviation;

    return json;
  }
}
