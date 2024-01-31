import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/service/schedule_service.dart';

import '../../domain/models/schedule.dart';
import 'calendar.dart';
import 'cardsList.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;
  final String theme;
  final Color bgColor;
  final Color bgColor1;
  final VoidCallback? onTap;

  const ScheduleItem({super.key, required this.schedule, required this.theme, required this.bgColor, required this.bgColor1, this.onTap});
  ScheduleItem copyWith({
    Schedule? schedule,
    String? theme,
    Color? bgColor,
    Color? bgColor1,
    VoidCallback? onTap,
  }) {
    return ScheduleItem(
      schedule: schedule ?? this.schedule,
      theme: theme ?? this.theme,
      bgColor: bgColor ?? this.bgColor,
      bgColor1: bgColor1 ?? this.bgColor1,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
      child: Dismissible(
      key: UniqueKey(),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          // setState(() {
          //   cards.removeWhere((item) => item.key == UniqueKey());
          // });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Raspored deleted')),
          );
        } else if (direction == DismissDirection.endToStart) {
          // Handle editing if needed
        }
        return false;
      },
      onDismissed: (_) {},
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
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                theme,
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
                      schedule.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: bgColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: 5),
                    Text(
                      schedule.description,
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
          // Your card UI here
        ),
      ),
    )
    );
  }

}

class ScheduleList extends StatefulWidget {
  ScheduleList({Key? key}) : super(key: key);

  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  late List<Schedule> schedules;
  List<ScheduleItem> scheduleItems = [];
  final ScheduleService scheduleService = ScheduleService();

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    schedules = await scheduleService.getSchedulesWithPagination();
    scheduleItems = schedules.map((schedule) {
      return ScheduleItem(
        schedule: schedule,
        theme: "resources/images/3.jpg",
        bgColor: Color(0xFF1A237E),
        bgColor1: Color(0xFFFFFFFF),
      );
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            return scheduleItem.copyWith(
              onTap: () {
                navigateToCalendar(scheduleItem.schedule);
              },
            );
          }).toList(),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewScreen()),
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
        builder: (context) => CalendarApp(schedule),
      ),
    );
  }
}
