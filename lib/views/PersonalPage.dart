import 'package:flutter/material.dart';
import 'package:fynnet_survey_demo/data_interface.dart';
import 'package:fynnet_survey_demo/data_models.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key, this.title, this.userId}) : super(key: key);
  final String title;
  final String userId;

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    print('userid inside personalpage: ${widget.userId}');

    // Defining tabs in page
    List<PersonalTab> _tabs = [
      PersonalTab(
        title: 'My Surveys',
        icon: Icons.comment,
        content: Card(
          child: ListView(
            children: getSurveysFromUser(userId: widget.userId).map((Survey survey) =>
              _createSurveyListTile(survey)
            ).toList()
          )
        ),
      ),
      PersonalTab(
        title: 'Answered Surveys',
        icon: Icons.check_box,
        content: Card(
          child: ListView(
            children: getSurveysFromUser(userId: widget.userId).map((Survey survey) =>
              _createSurveyListTile(survey)
            ).toList()
          )
        ),
      )
    ];

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
          children: _tabs.map( (PersonalTab tab) => tab.content ).toList()
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

// Creates a ListTile of the provided survey information, with different interactions depending on edit access
Widget _createSurveyListTile(Survey survey, {bool editAccess = false}) {
  Widget _respondButton = _buttonWithLabel('Respond', Icons.add_comment, () {});
  Widget _previewButton = _buttonWithLabel('Preview', Icons.remove_red_eye, () {});
  Widget _editButton = _buttonWithLabel('Edit', Icons.create, () {});
  Widget _resultsButton = _buttonWithLabel('Results', Icons.table_chart, () {});
  Widget _deleteButton = _buttonWithLabel('Delete', Icons.cancel, () {}, color: Colors.red[700]);

  return ExpansionTile(
    title : Text(survey.title, 
      style: TextStyle(
        fontWeight: FontWeight.w600,
      )
    ),
    subtitle : Text(survey.id), // TODO: change to something more meaningful

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