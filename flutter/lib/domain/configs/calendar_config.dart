import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class CalendarConfig {
  static late double timeRatioAllDays;
  static late double calRatioAllDays;
  static late double timeRatioOneDay;
  static late double calRatioOneDay;
  static late double offsetAllDays;
  static late double offsetOneDay;
  static late double timeNumAllDays;
  static late double calNumAllDays;
  static late double timeNumOneDay;
  static late double calNumOneDay;
  static late double heightOffset;

  static Future<void> forCalendar() async {
    final response = await html.HttpRequest.getString('calendar-config.json');
    final config = json.decode(response);
    offsetAllDays = config['offset_all_days'];
    offsetOneDay = config['offset_one_day'];
    heightOffset = config["height_offset"];

    calRatioAllDays = config['cal_ratio_all_days'];
    timeRatioAllDays = config['time_ratio_all_days'];
    calNumAllDays = calRatioAllDays / ((calRatioAllDays+timeRatioAllDays)*5);
    timeNumAllDays =  timeRatioAllDays / ((calRatioAllDays+timeRatioAllDays));

    calRatioOneDay= config['cal_ratio_one_day'];
    timeRatioOneDay = config['time_ratio_one_day'];
    calNumOneDay = calRatioOneDay / (calRatioOneDay +timeRatioOneDay);
    timeNumOneDay =  timeRatioOneDay / (calRatioOneDay+timeRatioOneDay);
  }
}