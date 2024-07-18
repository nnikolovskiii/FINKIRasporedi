import 'package:flutter/material.dart';

class TransparentSlotWidgetMin extends StatelessWidget {
  final double width;
  final double height;

  const TransparentSlotWidgetMin({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
