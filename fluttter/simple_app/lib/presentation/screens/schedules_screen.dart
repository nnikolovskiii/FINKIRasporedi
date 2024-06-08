import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/list/schedule_list_screen.dart';
import 'package:simple_app/service/auth_service.dart';
import 'package:simple_app/service/schedule_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'auth/login.dart';
import 'add/add_schedule_screen.dart';
import 'calendar_screen.dart';
import '../../domain/models/schedule.dart';

class SchedulesScreen extends StatefulWidget {
  @override
  _SchedulesScreenState createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  int _selectedIndex = 0;

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Распореди',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF123499),
          ),
        ),
        elevation: 20,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FutureBuilder<Map<String, dynamic>?>(
            future: AuthService.getLoggedInUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == null) {
                return IconButton(
                  icon: const Icon(Icons.account_circle_sharp),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                );
              } else {
                return Row(
                  children: [
                    Text(
                      snapshot.data!['username'],
                      style: const TextStyle(color: Color(0xFF123499)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        AuthService.logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_sharp),
            onPressed: () {
              _showImageDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ToggleButtons(
              isSelected: [_selectedIndex == 0, _selectedIndex == 1],
              onPressed: (index) {
                _onToggle(index);
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              color: Colors.black,
              constraints: BoxConstraints(minHeight: 40, minWidth: 150),
              children: const [
                Text('Finki Schedules'),
                Text('My Schedules'),
              ],
            ),
          ),
          Expanded(child: ScheduleListScreen(defaultValue: _selectedIndex == 0)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScheduleScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: Colors.grey,
              width: 3.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Color(0xFF123499)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Image.asset('resources/images/info.png'),
            ],
          ),
        );
      },
    );
  }
}