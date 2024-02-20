import 'package:flutter/material.dart';

import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../widgets/color_picker_widget.dart';




class FieldScreen extends StatefulWidget {
  final Schedule schedule;
  final LectureSlot? lectureSlot; // Nullable LectureSlot parameter

  FieldScreen({
    required this.schedule,
    this.lectureSlot, // Optional parameter
  });

  @override
  _FieldScreenState createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final TextEditingController nameController = TextEditingController();
  int selectedDayIndex = 0; // Default selection is Monday
  int selectedTimeFrom = 8; // Default selection is 0 hours
  int selectedTimeTo = 8; // Default selection is 0 hours

  @override
  void initState() {
    super.initState();
    // If lectureSlot is not null, set initial values based on lectureSlot
    if (widget.lectureSlot != null) {
      nameController.text = widget.lectureSlot!.name ?? "";
      selectedDayIndex = widget.lectureSlot!.day;
      selectedTimeFrom = widget.lectureSlot!.timeFrom.toInt();
      selectedTimeTo = widget.lectureSlot!.timeTo.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<int> hours = List<int>.generate(13, (index) => index + 8); // List of hours from 8 to 20


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Field Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(labelText: 'Name'),
              // ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Име",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor:  Color(0xFF123499).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.drive_file_rename_outline)),
              ),
              SizedBox(height: 20),

              DropdownButtonFormField<int>(
                value: selectedDayIndex,
                onChanged: (int? newIndex) {
                  setState(() {
                    selectedDayIndex = newIndex!;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Day",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color(0xFF123499).withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                items: const [
                  DropdownMenuItem<int>(
                    value: 0,
                    child: Text('Понеделник'),
                  ),
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Вторник'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Среда'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Четврток'),
                  ),
                  DropdownMenuItem<int>(
                    value: 4,
                    child: Text('Петок'),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<int>(
                          value: selectedTimeFrom,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedTimeFrom = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Од (часот)',
                            hintText: "Од ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor:Color(0xFF123499).withOpacity(0.1),
                            filled: true,
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          items: hours.map((hour) {
                            return DropdownMenuItem<int>(
                              value: hour,
                              child: Text(hour.toString()),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<int>(
                          value: selectedTimeTo,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedTimeTo = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'До (часот)',
                            hintText: "до",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Color(0xFF123499).withOpacity(0.1),
                            filled: true,
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          items: hours.map((hour) {
                            return DropdownMenuItem<int>(
                              value: hour,
                              child: Text(hour.toString()),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  print('Selected Day Index: $selectedDayIndex');
                  print('Time From: $selectedTimeFrom');
                  print('Time To: $selectedTimeTo');

                  // If lectureSlot is null, it's a new lecture slot, else it's editing
                  if (widget.lectureSlot == null) {
                    // Create a new LectureSlot object
                    LectureSlot newLectureSlot = LectureSlot(
                      name: name,
                      day: selectedDayIndex,
                      timeFrom: selectedTimeFrom.toDouble(),
                      timeTo: selectedTimeTo.toDouble(),
                    );

                    // Navigate to ColorPickerScreen for saving new lecture slot
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ColorPickerScreen(
                          schedule: widget.schedule,
                          lectureSlot: newLectureSlot,
                            update: false
                        ),
                      ),
                    );
                  } else {
                    // Modify existing LectureSlot object
                    widget.lectureSlot!.name = name;
                    widget.lectureSlot!.day = selectedDayIndex;
                    widget.lectureSlot!.timeFrom = selectedTimeFrom.toDouble();
                    widget.lectureSlot!.timeTo = selectedTimeTo.toDouble();

                    // Navigate back
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ColorPickerScreen(
                          schedule: widget.schedule,
                          lectureSlot: widget.lectureSlot!,
                          update: true,
                          color:widget.lectureSlot!.hexColor
                        ),
                      ),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        )
      ),
    );
  }
}
