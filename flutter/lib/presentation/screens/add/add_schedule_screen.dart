import 'package:flutter/material.dart';

import 'package:flutter_app/domain/models/schedule.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';

import '../../../service/schedule_service.dart';

class AddScheduleScreen extends StatefulWidget {
  final ScheduleService scheduleService = ScheduleService();
  final Schedule? schedule;

  AddScheduleScreen({super.key, this.schedule});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _nameEditingController.text = widget.schedule!.name;
      _notesEditingController.text = widget.schedule!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF375e94),
        title: const Text(
          "Креирај распоред",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF8F8F8F),
        ),
        elevation: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Center the image at the top
              Center(
                child: Image.asset(
                  'resources/images/scheduling.png', // Replace with the correct path to your image
                  width: 180, // Adjust size as needed
                  height: 180,
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _nameEditingController,
                decoration: InputDecoration(
                  hintText: "Внеси име на распоред",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xFF123499).withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.create_rounded),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ве молиме внесете име на распоред';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),
              TextFormField(
                controller: _notesEditingController,
                decoration: InputDecoration(
                  hintText: "Внеси забелешки за распоредот",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xFF123499).withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.create_rounded),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String name = _nameEditingController.text;
                      String notes = _notesEditingController.text;
                      Schedule schedule = Schedule(name: name, description: notes);

                      if (widget.schedule == null) {
                        await widget.scheduleService.addSchedule(schedule);
                      } else {
                        schedule.id = widget.schedule!.id;
                        await widget.scheduleService.updateSchedule(schedule.id!, schedule);
                      }
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(initialIndex: 1),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF375e94)),
                  ),
                  child: const Text(
                    'Продолжи',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
