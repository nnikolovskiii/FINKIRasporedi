import 'package:flutter/material.dart';

import '../../../domain/configs/calendar_config.dart';

class VerticalDividerWidget extends StatelessWidget {
  final double numCells;
  final Color color;
  final bool edge;

  const VerticalDividerWidget(
      {super.key,
      required this.numCells,
      required this.color,
      required this.edge});

  @override
  Widget build(BuildContext context) {
    double paddingHeight = 0;
    double offset = 0;
    if (!edge) {
      paddingHeight = 8;
      offset = 1000;
    }
    double height = MediaQuery.of(context).size.height - 176.4;
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 2.0,
          height: ((height * 1 / 13) - CalendarConfig.heightOffset) * numCells +
              paddingHeight * numCells +
              offset,
          color: color,
        ));
  }
}
