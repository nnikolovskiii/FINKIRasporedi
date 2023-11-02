import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';



class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}


class _CardListState extends State<CardList> {
  List<Widget> cards = []; // List to store your card widgets

  @override
  void initState() {
    super.initState();
    // Populate the initial card list
    for (int i = 0; i < 2; i++) {
      cards.add(buildCard("Notes za raspored $i ", "Sub title", "Notes"));
    }
  }

  Color myCustomColor = Color(0xFFB9CDD7);
  Color myCustomColor2 = Color(0xFF1C3144);

  Widget buildCard(String title, String subTitle, String cardText) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding around the entire card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),

        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: myCustomColor, // Set the background color to gray
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'lib/images/3.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(25), // Add padding to the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Raspored",
                    style: TextStyle(
                      fontSize: 24,
                      color: myCustomColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 5),
          ],
        ),
      ),
    );
  }


  // Function to add a new card to the list
  void addCard() {
    setState(() {
      cards.add(buildCard("New Card", "Sub title", "New card text"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card List"),
      ),
      body: ListView(
        children: cards, // Display the list of card widgets
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCard, // Call addCard function when the button is pressed
        child: Icon(Icons.add),
      ),
    );
  }
}


