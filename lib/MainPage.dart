import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: _buildSurveyList()
        ),
    );
  }
}

Widget _buildSurveyList() => ListView(
  children: <ListTile>[
                  _survey('Number one', 'first one', 234),
                  _survey('Number two', 'second', 76, true),
                  _survey('Third', '', 3),
                  _survey('testing', '', 2)
                ],
);

ListTile _survey(String title, String description, int views, [bool answered = false]) {
  return ListTile(
    title: Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: answered ? Colors.grey : Colors.black,
        decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
      )
    ),
    subtitle: Text(description,
      style: TextStyle(
        color: answered ? Colors.grey[400] : Colors.grey[600],
        decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
      )
    ),
    leading: Icon(
      answered ? Icons.check_box : Icons.check_box_outline_blank, 
      color: Colors.green[700]
    ),
    trailing: Icon(Icons.keyboard_arrow_right),

    onTap: () {
      print('You just tapped the survey $title.');
    }
  );
}