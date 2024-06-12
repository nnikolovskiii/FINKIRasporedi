import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final int day;
  final int num;
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

  const DayWidget({super.key, required this.day, this.num = 6});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double itemWidth = (width - 90) / num;

    bool useShortNames = itemWidth < 60;
    String dayName = useShortNames ? shortDaysMap[day]! : fullDaysMap[day]!;

    double fontSize = useShortNames ? 14 : 16;

    return SizedBox(
      height: 50,
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
