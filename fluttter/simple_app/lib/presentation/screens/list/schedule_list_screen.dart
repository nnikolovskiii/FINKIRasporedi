import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/service/schedule_service.dart';

import '../../../domain/models/schedule.dart';
import '../add/add_schedule_screen.dart';
import '../calendar_screen.dart';

class ScheduleItem extends StatefulWidget {
  final ScheduleService scheduleService = ScheduleService();
  final Schedule schedule;
  final String theme;
  final Color bgColor;
  final Color bgColor1;
  final VoidCallback? onTap;

  ScheduleItem({
    Key? key,
    required this.schedule,
    required this.theme,
    required this.bgColor,
    required this.bgColor1,
    this.onTap,
  }) : super(key: key);

  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: isDeleted
          ? SizedBox() // Empty SizedBox when the item is deleted
          : Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            bool confirmDelete = await showDeleteConfirmationDialog(context);
            if (confirmDelete) {
              await widget.scheduleService.deleteSchedule(widget.schedule.id ?? -1);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Raspored deleted')),
              );
              setState(() {
                isDeleted = true;
              });
            }
          } else if (direction == DismissDirection.endToStart) {
            // Handle editing if needed
          }
          return false;
        },
        onDismissed: (_) {
          // Handle any additional logic after dismissal if needed
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Icons.edit, color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 11.0, 8.0, 15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: widget.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  widget.theme,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.schedule.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.bgColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        widget.schedule.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Schedule"),
          content: Text("Are you sure you want to delete this schedule?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

class ScheduleListScreen extends StatefulWidget {
  ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late List<Schedule> schedules;
  final ScheduleService scheduleService = ScheduleService();

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    schedules = await scheduleService.getSchedulesWithPagination();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<ScheduleItem> scheduleItems = schedules.map((schedule) {
      return ScheduleItem(
        key: ValueKey(schedule.id), // Added a key
        schedule: schedule,
        theme: "resources/images/3.jpg",
        bgColor: Color(0xFF1A237E),
        bgColor1: Color(0xFFFFFFFF),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule List",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView(
        children: scheduleItems.map((scheduleItem) {
          return scheduleItem; // Use the instance directly
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScheduleScreen()),
          );

          if (result != null) {
            String scheduleDetails = result[0];
            String selectedTheme = result[1];
            // setState(() {
            //   cards.add(buildCard(scheduleDetails, "Sub title", selectedTheme));
            // });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToCalendar(Schedule schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarScreen(schedule.id ?? 0),
      ),
    );
  }
}
