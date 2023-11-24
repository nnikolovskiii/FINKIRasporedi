import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    // Populate the initial card list
    for (int i = 0; i < 3; i++) {
      cards.add(buildCard("Notes za raspored $i ", "Sub title"));
    }
  }

  Color myCustomColor2 = Color(0xFFFFFFFF);
  Color myCustomColor = Color(0xFF1A237E);

  Widget buildCard(String title, String subTitle) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text('Delete'),
                content: Container(
                  width: 300,
                  child: Text('Are you sure to delete?'),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                actions: [
                  TextButton(
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                  TextButton(
                    child: Text("No"),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ],
              ),
            );
          },
        );
      },
      onDismissed: (DismissDirection direction) {
        setState(() {
          cards.removeWhere((item) => item.key == UniqueKey());
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Raspored deleted')),
        );
      },
      background: Container(
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/deletes.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
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
                'lib/images/4.jpg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.all(25),
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToNewScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewScreen()),
    );

    if (result != null) {
      setState(() {
        cards.add(buildCard(result, result));
      });
    }
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
        onPressed: navigateToNewScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter your text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String enteredText = _textEditingController.text;
                Navigator.pop(context, enteredText); // Pass entered text back
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
