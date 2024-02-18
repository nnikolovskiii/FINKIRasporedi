import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final int day;
  static const Map<int, String> daysMap = {
    0: "Понделник",
    1: "Вторник",
    2: "Среда",
    3: "Четврток",
    4: "Петок"
  };

  const DayWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: Center(
        child: Text(
          daysMap[day]!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
              color: Color(0xFF3585b8),
          ), // Replace with your actual text
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Other widgets
              DayWidget(day: 0),
              // Other widgets
            ],
          ),
        ),
      ),
    ),
  );
}
