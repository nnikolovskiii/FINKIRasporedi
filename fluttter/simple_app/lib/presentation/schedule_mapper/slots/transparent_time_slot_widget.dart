import 'package:flutter/material.dart';

class TransparentTimeSlotWidget extends StatefulWidget {
  const TransparentTimeSlotWidget({Key? key}) : super(key: key);

  @override
  _TransparentTimeSlotWidgetState createState() =>
      _TransparentTimeSlotWidgetState();
}

class _TransparentTimeSlotWidgetState extends State<TransparentTimeSlotWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() => isHovered = true);
        // Get the position and print it
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        print("Widget position: $offset");
      },
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: isHovered
              ? Colors.grey.withOpacity(0.4) // Adjust alpha value as needed
              : Colors.transparent,
          // Adjust the radius as needed
        ),
      ),
    );
  }
}
