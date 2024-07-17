import 'package:flutter/material.dart';
import 'package:flutter_app/domain/configs/calendar_config.dart';

class DayWidget extends StatelessWidget {
  final bool allDays;
  final int day;

  static const Map<int, String> fullDaysMap = {
    0: "Понделник",
    1: "Вторник",
    2: "Среда",
    3: "Четврток",
    4: "Петок"
  };

  static const Map<int, String> shortDaysMap = {
    0: "Пон",
    1: "Вто",
    2: "Сре",
    3: "Чет",
    4: "Пет"
  };

  const DayWidget({super.key, required this.day, required this.allDays});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 176.4;
    double itemWidth = allDays
        ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
        : (width - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay;

    bool useShortNames = itemWidth < 60;
    String dayName = useShortNames ? shortDaysMap[day]! : fullDaysMap[day]!;

    double fontSize = useShortNames ? 14 : 16;

    return SizedBox(
      height: (height * 1 / 13) - CalendarConfig.heightOffset,
      width: itemWidth,
      child: Center(
        child: Text(
          dayName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3585b8),
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
