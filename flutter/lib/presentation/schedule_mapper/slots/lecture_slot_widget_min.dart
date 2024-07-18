import 'package:flutter/material.dart';

class LectureSlotWidgetMin extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const LectureSlotWidgetMin({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
