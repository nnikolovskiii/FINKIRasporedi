
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simple_app/presentation/widgets/themeButtonWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'addSubjectsScreen.dart';



void main() {
  runApp(MaterialApp(
    home: CardList(),
  ));
}

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  List<Widget> cards = [];
  String selectedTheme = "lib/images/3.jpg";

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      cards.add(buildCard("Notes za raspored $i ", "Sub title", selectedTheme));
    }
  }

  Color myCustomColor2 = Color(0xFFFFFFFF);
  Color myCustomColor = Color(0xFF1A237E);
  // String selectedTheme ="lib/images/4.jpg" ;

  Widget buildCard(String title, String subTitle, String selectedTheme) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          setState(() {
            cards.removeWhere((item) => item.key == UniqueKey());
          });
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
          color: myCustomColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                selectedTheme,
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
                      "Raspored",
                      style: TextStyle(
                        fontSize: 20,
                        color: myCustomColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: 5),
                    Text(
                      title,
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
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Card List",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView(
        children: cards,
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
            setState(() {
              cards.add(buildCard(scheduleDetails, "Sub title", selectedTheme));
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();
  String selectedTheme ="lib/images/3.jpg" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('Креирај распоред'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              Text("Избери тема"),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ThemeButton(imagePath: 'lib/images/9.jpg', onTap: () {
                    setState(() {
                      selectedTheme = 'lib/images/9.jpg';
                    });
                  }),

                  ThemeButton(imagePath: 'lib/images/5.jpg', onTap: () {
                    setState(() {
                      selectedTheme = 'lib/images/5.jpg';
                    });
                  }),
                  ThemeButton(imagePath: 'lib/images/7.jpg', onTap: () {
                    setState(() {
                      selectedTheme = 'lib/images/7.jpg';
                    });
                  }),
                  ThemeButton(imagePath: 'lib/images/3.jpg', onTap: () {
                    setState(() {
                      selectedTheme = 'lib/images/3.jpg';
                    });
                  }),
                ],

              ),
              SizedBox(height: 20.0),
              GFButton(
                  color: Colors.blue,
                  shape: GFButtonShape.pills,
                  child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  }
              ),
              SizedBox(height: 8.0),
              GFButton(
                  color: Colors.blue,
                  shape: GFButtonShape.pills,
                  child: const Text(
                      "Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  }
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: _nameEditingController,
                decoration: InputDecoration(
                  labelText: 'Внеси име на распоред *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ве молиме внесете име на распоред';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _notesEditingController,
                decoration: InputDecoration(
                  labelText: 'Венси забелешки за распоредот',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(

                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameEditingController.text;
                    String notes = _notesEditingController.text;
                    String result = '$name - $notes';
                    Navigator.pop(context, [result, selectedTheme]); // Return selected theme
                  }
                },
                child: Text('Продолжи'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchBarApp()),
                  );
                },
                child: Text("Предмети"),
              )
            ],
          ),
        ),
      ),
    );
  }
  File? image;
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() {
        image = imageTemp;
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}