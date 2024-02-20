import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class HorizontalDividerWidget extends StatelessWidget {
  final bool hasColor;
  int num;

  HorizontalDividerWidget({super.key, required this.hasColor, this.num = 6});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(0,3.0, 0, 3.0),
        width:  (width-90)/num, // Adjust the width as needed
        height: 2.0, // Set height to fill available vertical space
        color: hasColor ? Colors.grey.shade300 : null);
  }
}
