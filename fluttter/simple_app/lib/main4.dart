import 'package:flutter/material.dart';

import 'main2.dart';
import 'main3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'Draggable Example',
      home: Stack(
        children: [
          MyTable(),
          DraggableExample(
            // Pass the callback function to DraggableExample
            onStateChange: (renderBox) {
              // Find the nearest MyTableState ancestor and call its updateState method
              MyTable.of(context)?.updateTableState(renderBox);
            },
          ),
        ],
      ),
    );
  }
}



