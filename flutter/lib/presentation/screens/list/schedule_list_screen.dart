import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/utils/not_logged_in_message_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/service/schedule_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../add/add_schedule_screen.dart';
import '../calendar/calendar_screen.dart';
import '../../../domain/models/schedule.dart';
import '../main_screen.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
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
    final isDefault =
        Provider.of<ScheduleProvider>(context, listen: false).isDefault;
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
    final isDefault = Provider.of<ScheduleProvider>(context).isDefault;

    return Scaffold(
      body: Column(
        children: [
          if (isDefault)
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Provider.of<ScheduleProvider>(context, listen: false)
                        .setName('');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MainScreen(initialIndex: 0)),
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: FutureBuilder<List<Schedule>>(
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
                    return const NotLoggedInMessageScreen();
                  } else {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                } else if (snapshot.hasData) {
                  List<ScheduleItem> scheduleItems =
                      snapshot.data!.map((schedule) {
                    return ScheduleItem(
                      schedule: schedule,
                      theme: "resources/images/bgImg.jpg",
                      bgColor: Colors.blue.shade900.withOpacity(0.8),
                      bgColor1: const Color(0xFFFFFFFF),
                      isDefault: isDefault,
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
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final ScheduleService scheduleService = ScheduleService();
  final Schedule schedule;
  final String theme;
  final Color bgColor;
  final Color bgColor1;
  final bool isDefault;

  ScheduleItem({
    super.key,
    required this.schedule,
    required this.theme,
    required this.bgColor,
    required this.bgColor1,
    required this.isDefault,
  });

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
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  theme,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
                    if (!isDefault)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScheduleScreen(
                                          schedule: schedule,
                                        )),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              bool? confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Потврди бришење:'),
                                    content: const Text(
                                        'Дали сте сигурни дека сакате да го избришете распоредот?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text('Откажи'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text('Избриши'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmDelete == true) {
                                await scheduleService
                                    .deleteSchedule(schedule.id ?? 0);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen(initialIndex: 1)),
                                );
                              }
                            },
                          ),
                        ],
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
