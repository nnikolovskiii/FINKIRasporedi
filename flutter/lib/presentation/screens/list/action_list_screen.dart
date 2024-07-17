import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/calendar/professor_calendar_screen.dart';
import 'package:flutter_app/presentation/screens/calendar/room_calendar_screen.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../../../domain/providers/schedule_provider.dart';

class ActionListScreen extends StatelessWidget {
  const ActionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCard(context, 'Смер', const Color(0xFF315DA8)),
          _buildCard(context, 'Професор', const Color(0xFFDE6287)),
          _buildCard(context, 'Просторија', const Color(0xFFE77672)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Color color) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Смер':
            Provider.of<ScheduleProvider>(context, listen: false)
                .setName(title);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainScreen(initialIndex: 0)),
            );
            break;
          case 'Професор':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfessorCalendarScreen()),
            );
            break;
          case 'Просторија':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RoomCalendarScreen()),
            );
            break;
          default:
        }
      },
      child: Card(
        color: color,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
