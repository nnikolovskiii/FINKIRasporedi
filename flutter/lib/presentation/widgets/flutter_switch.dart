import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  bool showAllDays = false;
  int num = 1;
  int currentPage = 0;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: Center(
        child: FlutterSwitch(
          width: 100.0,
          height: 55.0,
          valueFontSize: 15.0,
          toggleSize: 45.0,
          value: showAllDays,
          borderRadius: 30.0,
          padding: 8.0,
          activeText: 'Сите денови',
          inactiveText: 'Еден ден',
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          activeTextColor: Colors.white,
          inactiveTextColor: Colors.white,
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              showAllDays = val;
              num = showAllDays ? 5 : 1;
              if (showAllDays) {
                controller.jumpToPage(0);
                currentPage = 0;
              }
            });
          },
        ),
      ),
    );
  }
}
