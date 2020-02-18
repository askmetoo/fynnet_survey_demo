import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'schemas.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,

      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: _tabs.map( (PersonalTab tab) => Tab(text: tab.title, icon: Icon(tab.icon)) ).toList()
          ),
        ),
        body: TabBarView(
          children: _tabs.map((PersonalTab tab) => tab.content).toList()
        ),
      ),
    );
  }
}

class PersonalTab {
  final String title;
  final IconData icon;
  final Widget content;
  PersonalTab({this.title, this.icon, this.content});
}

// Define the tabs that are shown in the PersonalPage
List<PersonalTab> _tabs = [
  PersonalTab(
    title: 'My Surveys',
    icon: Icons.comment,
    content: personalSurveyTab,
  ),
  PersonalTab(
    title: 'Answered Surveys',
    icon: Icons.check_box,
    content: personalAnsweredTab,
  )
];

// Define the content in each tab
Widget personalSurveyTab = Card(
  //child: Expanded(
    child: ListView(
      children: [
        _createSurveyListTile(
          title: 'First survey blahblahblah',
          subtitle: 'Created on Mar 20, 2020',
          editAccess: true
        ),
        _createSurveyListTile(
          title: 'Consumer market research survey',
          subtitle: 'Created on Apr 12, 2020',
          editAccess: true
        ),
      ]
    )
  //)
);
Widget personalAnsweredTab = Card(
  //child: Expanded(
    child: ListView(
      children: [
        _createSurveyListTile(
          title: 'What flavor poptart are you?',
          subtitle: 'Created on Mar 20, 2020',
        ),
        _createSurveyListTile(
          title: 'Which Hogwarts house are you in?',
          subtitle: 'Created on Apr 12, 2020',
        ),
        _createSurveyListTile(
          title: 'What is your MBTI profile?',
          subtitle: 'Created on Apr 12, 2020',
        ),
      ]
    )
  //)
);

// Creates a ListTile of the provided survey information, with different interactions depending on edit access
Widget _createSurveyListTile({String title, String subtitle, bool editAccess = false}) {
  Widget _respondButton = _buttonWithLabel('Respond', Icons.add_comment, () {});
  Widget _previewButton = _buttonWithLabel('Preview', Icons.remove_red_eye, () {});
  Widget _editButton = _buttonWithLabel('Edit', Icons.create, () {});
  Widget _resultsButton = _buttonWithLabel('Results', Icons.table_chart, () {});
  Widget _deleteButton = _buttonWithLabel('Delete', Icons.cancel, () {}, color: Colors.red[700]);

  return ExpansionTile(
    title : Text(title, 
      style: TextStyle(
        fontWeight: FontWeight.w600,
      )
    ),
    subtitle : Text(subtitle),

    // Expands on tap to reveal additional options
    children : [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: editAccess ? [
          // Buttons that show when user has edit access
          _previewButton,
          _editButton,
          _resultsButton,
          _deleteButton
        ] : [
          // Buttons that show when user does not have edit access
          _respondButton,
          _resultsButton
        ]
      )
    ]
  );
}

// Button that will appear below selected survey in listing
MaterialButton _buttonWithLabel(String label, IconData icon, Function onPressed, {Color color = Colors.black}) {
  return FlatButton(
    child: Column(
      children: [
        Icon(icon, color: color, size: 16),
        Text(label, 
          style: TextStyle(
            color: color,
            fontSize: 12
          )
        )
      ]
    ),
    onPressed: onPressed,
  );
}