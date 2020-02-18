import 'package:flutter/material.dart';

import 'Login.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Map> surveys = [
    {
      'id' : '1',
      'title' : 'First survey',
      'author' : 'Albert A.',
      'views' : 234,
      'responses' : 10,
    },
    {
      'id' : '2',
      'title' : 'Second survey',
      'author' : 'Brittany B.',
      'views' : 74,
      'responses' : 23,
    },
    {
      'id' : '3',
      'title' : 'This survey\'s name is too long to fit into one line, so it should be truncated',
      'author' : 'Anonymous',
      'views' : 9,
      'responses' : 2,
    }
  ];

  @override
  Widget build(BuildContext context) {
    MaterialButton _accountButton = FlatButton(
      textColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.person),
          Text('Your Account')
        ]
      ),
      onPressed: () => showDialog(
        context: context, 
        builder: (BuildContext context) => new LoginDialog()
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          _accountButton
        ]
      ),

      body: Center(
        child: Column(
          children: [
            Card(child: Text('Insert search box here')), // TODO: add search functionality

            // Show the 5 (?) most viewed/answered surveys which the user (if logged in) has not yet answered or dismissed
            Text('Our most popular surveys',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )
            ),
            _buildSurveyList(surveys),

          ]
        )
      ),
    );
  }
}

Widget _buildSurveyList(List surveys) => Expanded(
  child: ListView.builder(
    itemCount: surveys.length,
    itemBuilder: (BuildContext context, int index) => _surveyListing(surveys[index]),
  )
);

// Creates a ListTile of provided survey object to be fed into a ListView
ListTile _surveyListing(Map survey, [bool answered = false]) {
  final String title = survey['title'];
  return ListTile(
    title: Text(survey['title'],
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: answered ? Colors.grey : Colors.black,
        decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
      )
    ),
    subtitle: Text('Created by: ${survey['author']}',
      style: TextStyle(
        color: answered ? Colors.grey[400] : Colors.grey[600],
        decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
      )
    ),
    leading: Icon(
      Icons.comment, 
      color: Colors.green[700]
    ),
    trailing: Icon(Icons.keyboard_arrow_right),

    onTap: () {
      print('You just tapped the survey $title.');
    }
  );
}