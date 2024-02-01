import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/lecture.dart';

class LectureEditScreen extends StatefulWidget {
  final Lecture? lecture;

  LectureEditScreen({required this.lecture});

  @override
  _LectureEditScreenState createState() => _LectureEditScreenState();
}

class _LectureEditScreenState extends State<LectureEditScreen> {
  late TextEditingController nameController;
  late TextEditingController dayController;
  late TextEditingController timeFromController;
  late TextEditingController timeToController;
  late TextEditingController professorController;
  late TextEditingController courseController;
  late TextEditingController roomController;
  late TextEditingController typeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.lecture?.name ?? '');
    dayController =
        TextEditingController(text: widget.lecture?.day?.toString() ?? '');
    timeFromController =
        TextEditingController(text: widget.lecture?.timeFrom?.toString() ?? '');
    timeToController =
        TextEditingController(text: widget.lecture?.timeTo?.toString() ?? '');
    professorController =
        TextEditingController(text: widget.lecture?.professor?.name ?? '');
    courseController =
        TextEditingController(text: widget.lecture?.course?.id ?? '');
    roomController =
        TextEditingController(text: widget.lecture?.room?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lecture == null ? 'Add Lecture' : 'Edit Lecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Lecture Name'),
            ),
            TextFormField(
              controller: dayController,
              decoration: InputDecoration(labelText: 'Day'),
            ),
            TextFormField(
              controller: timeFromController,
              decoration: InputDecoration(labelText: 'Time From'),
            ),
            TextFormField(
              controller: timeToController,
              decoration: InputDecoration(labelText: 'Time To'),
            ),
            TextFormField(
              controller: professorController,
              decoration: InputDecoration(labelText: 'Professor'),
            ),
            TextFormField(
              controller: courseController,
              decoration: InputDecoration(labelText: 'Course'),
            ),
            TextFormField(
              controller: roomController,
              decoration: InputDecoration(labelText: 'Room'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the lecture here
                // You can use the controllers to get the values
                // and create a new Lecture instance or update the existing one.
                // You may want to validate the input before saving.

                // Handle adding or editing logic based on whether lecture is null or not.
                if (widget.lecture == null) {
                  // Add logic here
                } else {
                  // Edit logic here
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  String jsonString =
      '{"lectures":[{"id":1,"name":null,"originalLecture":null,"day":0,"timeFrom":"08:00:00","timeTo":"09:45:00","professor":{"id":"aleksandar.stojmenski","name":"Александар Стојменски","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"315 ТМФ"},"type":0},{"id":6,"name":null,"originalLecture":null,"day":0,"timeFrom":"14:00:00","timeTo":"14:45:00","professor":{"id":"aleksandar.tenev","name":"Александар Тенев","email":null,"professorTitle":null},"course":{"id":"W23biznis.i.menadzhment","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"biznis.i.menadzhment","name":"Бизнис и менаџмент","level":1,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":7,"name":null,"originalLecture":null,"day":1,"timeFrom":"14:00:00","timeTo":"14:45:00","professor":{"id":"aleksandar.tenev","name":"Александар Тенев","email":null,"professorTitle":null},"course":{"id":"W23biznis.i.menadzhment","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"biznis.i.menadzhment","name":"Бизнис и менаџмент","level":1,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":9,"name":null,"originalLecture":null,"day":2,"timeFrom":"14:00:00","timeTo":"15:45:00","professor":{"id":"aleksandar.tenev","name":"Александар Тенев","email":null,"professorTitle":null},"course":{"id":"W23ekonomija.za.ikt.inzheneri","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"ekonomija.za.ikt.inzheneri","name":"Економија за ИКТ инженери","level":2,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":12,"name":null,"originalLecture":null,"day":1,"timeFrom":"10:00:00","timeTo":"12:45:00","professor":{"id":"aleksandra.dedinets","name":"Александра Дединец","email":null,"professorTitle":null},"course":{"id":"W23voved.vo.pametni.gradovi","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"voved.vo.pametni.gradovi","name":"Вовед во паметни градови","level":3,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":23,"name":null,"originalLecture":null,"day":0,"timeFrom":"15:00:00","timeTo":"16:45:00","professor":{"id":"ana.todorovska","name":"Ана Тодоровска","email":null,"professorTitle":null},"course":{"id":"W23napredno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"napredno.programiranje","name":"Напредно програмирање","level":2,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":44,"name":null,"originalLecture":null,"day":2,"timeFrom":"08:00:00","timeTo":"10:45:00","professor":{"id":"biljana.tojtovska.ribarski","name":"Билјана Тојтовска Рибарски","email":null,"professorTitle":null},"course":{"id":"W23diskretni.strukturi.1","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"diskretni.strukturi.1","name":"Дискретни структури 1","level":1,"abbreviation":null}},"room":{"name":"Барака 3.2"},"type":0},{"id":50,"name":null,"originalLecture":null,"day":3,"timeFrom":"08:00:00","timeTo":"11:45:00","professor":{"id":"boban.joksimoski","name":"Бобан Јоксимоски","email":null,"professorTitle":null},"course":{"id":"W23digitizatsija","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"digitizatsija","name":"Дигитизација","level":2,"abbreviation":null}},"room":{"name":"online"},"type":0},{"id":51,"name":null,"originalLecture":null,"day":3,"timeFrom":"14:00:00","timeTo":"15:45:00","professor":{"id":"boban.joksimoski","name":"Бобан Јоксимоски","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"315 ТМФ"},"type":0},{"id":119,"name":null,"originalLecture":null,"day":4,"timeFrom":"12:00:00","timeTo":"13:45:00","professor":{"id":"dejan.gjorgjevikj","name":"Дејан Ѓорѓевиќ","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"Барака 3.2"},"type":0},{"id":160,"name":null,"originalLecture":null,"day":4,"timeFrom":"08:00:00","timeTo":"09:45:00","professor":{"id":"dimitar.trajanov","name":"Димитар Трајанов","email":null,"professorTitle":null},"course":{"id":"W23veb.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"veb.programiranje","name":"Веб програмирање","level":3,"abbreviation":null}},"room":{"name":"Барака 2.2"},"type":0}],"lazyLoader":{},"id":1,"name":"raspored","description":"prv"}';

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: LectureEditScreen(
            lecture: null,
          ),
        ),
      ),
    ),
  );
}
