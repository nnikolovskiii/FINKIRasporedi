import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.0, // Adjust the width as needed
      height: 640+6*13, // Set height to fill available vertical space
      color: Colors.grey.shade300, // Set the color of the vertical line
    );
  }
}
