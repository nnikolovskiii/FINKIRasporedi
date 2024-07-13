import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/calendar/room_calendar_content_screen.dart';
import 'package:flutter_app/service/room_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:flutter_app/service/schedule_service.dart';
import '../../../domain/models/room.dart';
import '../../../domain/models/schedule.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../../widgets/ActionButton.dart';
import '../../widgets/ExpandableFab.dart';
import '../add/add_lecture_slot_screen.dart';
import '../list/course_list_screen.dart';

class RoomCalendarScreen extends StatefulWidget {
  const RoomCalendarScreen({super.key});

  @override
  _RoomCalendarScreenState createState() => _RoomCalendarScreenState();
}

class _RoomCalendarScreenState extends State<RoomCalendarScreen> {
  final ScheduleService scheduleService = ScheduleService();
  final RoomService roomService = RoomService();
  Schedule? scheduleFuture;
  List<Room>? rooms;
  late String roomId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    roomId = Provider.of<ScheduleProvider>(context, listen: false).room;
    Schedule schedule = await scheduleService.getScheduleByRoom(roomId);
    rooms = await roomService.getAllRooms();
    setState(() {
      scheduleFuture = schedule;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = Provider.of<ScheduleProvider>(context).isDefault;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0, // Remove default spacing
          leadingWidth: 40, // Adjust as needed to make the text closer
          title: GestureDetector(
            onTap: () {
              Provider.of<ScheduleProvider>(context, listen: false).setIsDefault(true);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            child: Text(
              scheduleFuture?.name ?? '',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF123499),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF123499)),
            onPressed: () {
              bool isDefault = Provider.of<ScheduleProvider>(context, listen: false).isDefault;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(initialIndex: isDefault ? 0 : 1),
                ),
              );
            },
          ),
          elevation: 20,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: scheduleFuture != null
                  ? Center(
                child: RoomCalendarContentScreen(
                  schedule: scheduleFuture!,
                  rooms: rooms!,
                ),
              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: LoadingAnimationWidget.prograssiveDots(
                    size: 80,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: isDefault
            ? null
            : ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.save),
            ),
            Row(
              children: [
                const Text(
                  "Custom",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0A2472)),
                ),
                const SizedBox(width: 5),
                ActionButton(
                  onPressed: () {
                    if (scheduleFuture != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FieldScreen(schedule: scheduleFuture!),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.dashboard_customize),
                ),
              ],
            ),
            ActionButton(
              onPressed: () {
                if (scheduleFuture != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add_circle_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
