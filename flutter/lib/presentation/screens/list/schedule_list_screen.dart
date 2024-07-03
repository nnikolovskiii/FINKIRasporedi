import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/utils/not_logged_in_message_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/service/schedule_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../auth/login.dart';
import '../calendar_screen.dart';
import '../../../domain/models/schedule.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late Future<List<Schedule>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = fetchSchedules();
  }

  @override
  void didUpdateWidget(ScheduleListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    futureSchedules = fetchSchedules();
  }

  Future<List<Schedule>> fetchSchedules() async {
    final isDefault = Provider.of<ScheduleProvider>(context, listen: false).isDefault;
    if (isDefault) {
      return await ScheduleService().getDefaultSchedulesWithPagination();
    } else {
      try {
        return await ScheduleService().getStudentSchedules();
      } catch (e) {
        throw Exception('not_logged_in');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Schedule>>(
      future: futureSchedules,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: LoadingAnimationWidget.prograssiveDots(
                size: 80,
                color: Colors.blue.shade800,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          if (snapshot.error.toString().contains('not_logged_in')) {
            return NotLoggedInMessageScreen();
          } else {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
        } else if (snapshot.hasData) {
          List<ScheduleItem> scheduleItems = snapshot.data!.map((schedule) {
            return ScheduleItem(
              schedule: schedule,
              theme: "resources/images/bgImg.jpg",
              bgColor: Colors.blue.shade900.withOpacity(0.8),
              bgColor1: const Color(0xFFFFFFFF),
            );
          }).toList();

          return ListView(
            children: scheduleItems,
          );
        } else {
          return const Center(
            child: Text('No data found'),
          );
        }
      },
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;
  final String theme;
  final Color bgColor;
  final Color bgColor1;

  const ScheduleItem({
    Key? key,
    required this.schedule,
    required this.theme,
    required this.bgColor,
    required this.bgColor1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalendarScreen(schedule.id ?? 0),
          ),
        );
      },
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
                      ),
                    ),
                    const SizedBox(height: 5),
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
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
