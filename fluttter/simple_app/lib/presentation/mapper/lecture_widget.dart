import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String text;

  CustomContainer({
    required this.height,
    required this.width,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
      ),
      child:
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown, // Choose the fitting strategy
                      child: Text(
                        'Container 1',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain, // Use a fitting strategy that scales up for the middle container
                      child: Text(
                        'Container 2 (Bigger)',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Container 3',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomContainer(
            height: 150.0,
            width: 100.0,
            color: Colors.purple,
            text: "Hello!",
          ),
        ),
      ),
    ),
  );
}
