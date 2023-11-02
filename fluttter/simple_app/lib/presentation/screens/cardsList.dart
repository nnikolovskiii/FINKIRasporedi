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
      cards.add(buildCard("Raspored $i ", "Sub title", "Notes"));
    }
  }

  Widget buildCard(String title, String subTitle, String cardText) {
    return Container(
      height: 200, // Set the desired height
      width: 300,  // Set the desired width
      child: Padding(
        padding: const EdgeInsets.all(15.0), // Adjust the padding as needed
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/bg.jpg',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 5),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Container(height: 5),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Container(height: 10),
                        // Text(
                        //   cardText,
                        //   maxLines: 2,
                        //   style: MyTextSample.subhead(context)!.copyWith(
                        //     color: Colors.grey[700],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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


