import 'package:flutter/material.dart';

import 'package:simple_app/domain/models/schedule.dart';

import '../../../service/schedule_service.dart';
import '../list/schedule_list_screen.dart';

class AddScheduleScreen extends StatefulWidget {
  final ScheduleService scheduleService =
      ScheduleService(); // Initialize LectureService
  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Креирај распоред'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 20.0),
              // Text("Избери тема"),
              // Row(
              //
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     ThemeButton(imagePath: 'resources/images/9.jpg', onTap: () {
              //       setState(() {
              //         selectedTheme = 'resources/images/9.jpg';
              //       });
              //     }),
              //
              //     ThemeButton(imagePath: 'resources/images/5.jpg', onTap: () {
              //       setState(() {
              //         selectedTheme = 'resources/images/5.jpg';
              //       });
              //     }),
              //     ThemeButton(imagePath: 'resources/images/7.jpg', onTap: () {
              //       setState(() {
              //         selectedTheme = 'resources/images/7.jpg';
              //       });
              //     }),
              //     ThemeButton(imagePath: 'resources/images/3.jpg', onTap: () {
              //       setState(() {
              //         selectedTheme = 'resources/images/3.jpg';
              //       });
              //     }),
              //   ],
              //
              // ),
              // SizedBox(height: 20.0),
              // GFButton(
              //     color: Colors.blue,
              //     shape: GFButtonShape.pills,
              //     child: const Text(
              //         "Pick Image from Gallery",
              //         style: TextStyle(
              //             color: Colors.white70, fontWeight: FontWeight.bold
              //         )
              //     ),
              //     onPressed: () {
              //       pickImage(ImageSource.gallery);
              //     }
              // ),
              // SizedBox(height: 8.0),
              // GFButton(
              //     color: Colors.blue,
              //     shape: GFButtonShape.pills,
              //     child: const Text(
              //         "Pick Image from Camera",
              //         style: TextStyle(
              //             color: Colors.white70, fontWeight: FontWeight.bold
              //         )
              //     ),
              //     onPressed: () {
              //       pickImage(ImageSource.camera);
              //     }
              // ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: _nameEditingController,
                decoration: InputDecoration(
                  labelText: 'Внеси име на распоред',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ве молиме внесете име на распоред';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _notesEditingController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Внеси забелешки за распоредот',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameEditingController.text;
                    String notes = _notesEditingController.text;
                    Schedule schedule =
                        Schedule(name: name, description: notes);
                    widget.scheduleService.addSchedule(schedule);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleListScreen()));
                  }
                },
                child: Text('Продолжи'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleListScreen()));
                },
                child: Text("Предмети"),
              )
            ],
          ),
        ),
      ),
    );
  }
// Future<void> pickImage(ImageSource source) async {
//   try {
//     final pickedImage = await ImagePicker().pickImage(source: source);
//     if (pickedImage == null) return;
//     final imageTemp = File(pickedImage.path);
//     setState(() {
//       image = imageTemp;
//     });
//   } catch (e) {
//     print('Failed to pick image: $e');
//   }
// }
}
