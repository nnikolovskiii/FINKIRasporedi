import 'package:flutter/material.dart';

class EmptyTimeSlotWidget extends StatelessWidget {
  const EmptyTimeSlotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: const Border(
          top: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        // Adjust the radius as needed
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
              EmptyTimeSlotWidget(),
              // Other widgets
            ],
          ),
        ),
      ),
    ),
  );
}
