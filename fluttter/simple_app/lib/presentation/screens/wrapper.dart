import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/domain/models/student.dart';

import 'auth/authenticate.dart';
import 'list/schedule_list_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student?>(context);
    // return either the Home or Authenticate widget
    return student != null ? const ScheduleListScreen() : const Authenticate();

  }
}