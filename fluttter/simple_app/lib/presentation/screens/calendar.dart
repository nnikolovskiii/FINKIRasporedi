import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/models/schedule.dart';
import '../mapper/schedule_widget.dart'; // Replace with the actual file name
import 'addSubjectsScreen.dart'; // Updated import statement

void main() {
  String jsonString = '{"lectures":[{"id":1,"name":null,"originalLecture":null,"day":0,"timeFrom":"08:00:00","timeTo":"09:45:00","professor":{"id":"aleksandar.stojmenski","name":"Александар Стојменски","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"315 ТМФ"},"type":0},{"id":6,"name":null,"originalLecture":null,"day":0,"timeFrom":"14:00:00","timeTo":"14:45:00","professor":{"id":"aleksandar.tenev","name":"Александар Тенев","email":null,"professorTitle":null},"course":{"id":"W23biznis.i.menadzhment","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"biznis.i.menadzhment","name":"Бизнис и менаџмент","level":1,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":7,"name":null,"originalLecture":null,"day":1,"timeFrom":"14:00:00","timeTo":"14:45:00","professor":{"id":"aleksandar.tenev","name":"Александар Тенев","email":null,"professorTitle":null},"course":{"id":"W23biznis.i.menadzhment","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"biznis.i.menadzhment","name":"Бизнис и менаџмент","level":1,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":9,"name":null,"originalLecture":null,"day":2,"timeFrom":"14:00:00","timeTo":"15:45:00","professor":{"id":"aleksandar.tenev","name":"Александар Тенев","email":null,"professorTitle":null},"course":{"id":"W23ekonomija.za.ikt.inzheneri","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"ekonomija.za.ikt.inzheneri","name":"Економија за ИКТ инженери","level":2,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":12,"name":null,"originalLecture":null,"day":1,"timeFrom":"10:00:00","timeTo":"12:45:00","professor":{"id":"aleksandra.dedinets","name":"Александра Дединец","email":null,"professorTitle":null},"course":{"id":"W23voved.vo.pametni.gradovi","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"voved.vo.pametni.gradovi","name":"Вовед во паметни градови","level":3,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":23,"name":null,"originalLecture":null,"day":0,"timeFrom":"15:00:00","timeTo":"16:45:00","professor":{"id":"ana.todorovska","name":"Ана Тодоровска","email":null,"professorTitle":null},"course":{"id":"W23napredno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"napredno.programiranje","name":"Напредно програмирање","level":2,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":44,"name":null,"originalLecture":null,"day":2,"timeFrom":"08:00:00","timeTo":"10:45:00","professor":{"id":"biljana.tojtovska.ribarski","name":"Билјана Тојтовска Рибарски","email":null,"professorTitle":null},"course":{"id":"W23diskretni.strukturi.1","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"diskretni.strukturi.1","name":"Дискретни структури 1","level":1,"abbreviation":null}},"room":{"name":"Барака 3.2"},"type":0},{"id":50,"name":null,"originalLecture":null,"day":3,"timeFrom":"08:00:00","timeTo":"11:45:00","professor":{"id":"boban.joksimoski","name":"Бобан Јоксимоски","email":null,"professorTitle":null},"course":{"id":"W23digitizatsija","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"digitizatsija","name":"Дигитизација","level":2,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":51,"name":null,"originalLecture":null,"day":3,"timeFrom":"14:00:00","timeTo":"15:45:00","professor":{"id":"boban.joksimoski","name":"Бобан Јоксимоски","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"315 ТМФ"},"type":0},{"id":119,"name":null,"originalLecture":null,"day":4,"timeFrom":"12:00:00","timeTo":"13:45:00","professor":{"id":"dejan.gjorgjevikj","name":"Дејан Ѓорѓевиќ","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"Барака 3.2"},"type":0},{"id":160,"name":null,"originalLecture":null,"day":4,"timeFrom":"08:00:00","timeTo":"09:45:00","professor":{"id":"dimitar.trajanov","name":"Димитар Трајанов","email":null,"professorTitle":null},"course":{"id":"W23veb.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"veb.programiranje","name":"Веб програмирање","level":3,"abbreviation":null}},"room":{"name":"Барака 2.2"},"type":0}],"lazyLoader":{},"id":1,"name":"raspored","description":"prv"}';

  Map<String, dynamic> jsonMap = json.decode(jsonString);
  Schedule schedule = Schedule.fromJson(jsonMap);

  runApp(MaterialApp(
    home: CalendarApp(schedule),
  ));
}
class CalendarApp extends StatelessWidget {
  final Schedule schedule;

  CalendarApp(this.schedule);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your App Title'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,


          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to a different screen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchBarApp(),
                    ),
                  );
                },
                child: Text('Add subjects'),
              ),
            ),
            Expanded(
              child: Center(
                child: ScheduleWidget(schedule: schedule),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
