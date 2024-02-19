import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:simple_app/domain/models/lecture_slots.dart';

import '../../domain/models/schedule.dart';
import '../../service/schedule_service.dart';
import '../screens/calendar_screen.dart';



class ColorPickerScreen extends StatefulWidget {
  final Schedule schedule;
  final LectureSlot lectureSlot;
  final ScheduleService scheduleService =
  ScheduleService(); // Initialize LectureService

  ColorPickerScreen({
    required this.schedule,
    required this.lectureSlot,
  });

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color selectedColor = Colors.blue; // Initial color
  TextEditingController hexController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Center(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                  hexController.text = color.toHex().toUpperCase();
                });
              },
              showLabel: true,
              enableAlpha: false,

            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: hexController,
              decoration: InputDecoration(
                labelText: 'Enter Hex Color',
                suffixIcon: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    _updateColorFromHex();
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selected Color',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Hex: ${selectedColor.toHex()}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    widget.lectureSlot.hexColor = selectedColor.toHex().toString();
                    await widget.scheduleService
                        .addLecture(widget.schedule.id ?? 0, widget.lectureSlot);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                        CalendarScreen(widget.schedule.id ?? 0),
                    ),
                    );
                  },
                  child: Text('Use Color'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateColorFromHex() {
    String hexCode = hexController.text.trim();
    if (RegExp(r'^#?[0-9A-Fa-f]{6}$').hasMatch(hexCode)) {
      setState(() {
        selectedColor = HexColor.fromHex(hexCode);
      });
    }
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex() {
    return '#${value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
