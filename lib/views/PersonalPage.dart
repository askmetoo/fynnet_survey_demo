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
  List<Widget> _createSurveysList() {
    Iterable<Survey> surveys = getSurveysFromUser(userId: widget.userId);
    return surveys.length == 0 ? 
      [
        Padding(padding: EdgeInsets.all(36),
          child: Text('No surveys found', 
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 18.0, 
              color: Theme.of(context).disabledColor
            )
          )
        )
      ] :
      surveys.map((Survey survey) => _createSurveyListTile(survey)).toList();
  } 
  List<Widget> _createResponsesList() {
    Iterable<SurveyResponse> responses = getResponsesByUser(widget.userId);
    return responses.length == 0 ? 
      [
        Padding(padding: EdgeInsets.all(36),
          child: Text('No responses found', 
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 18.0, 
              color: Theme.of(context).disabledColor
            )
          )
        )
      ] :
      responses.map((SurveyResponse response) => _createResponseListTile(response)).toList();
  } 

  @override
  Widget build(BuildContext context) {
    // Defining tabs in page
    List<PersonalTab> _tabs = [
      PersonalTab(
        title: 'My Surveys',
        icon: Icons.comment,
        content: Card(
          child: ListView(
            children: _createSurveysList()
          )
        ),
      ),
      PersonalTab(
        title: 'Answered Surveys',
        icon: Icons.check_box,
        content: Card(
          child: ListView(
            children: getResponsesByUser(widget.userId).map((SurveyResponse response) =>
              _createResponseListTile(response)
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

// Creates a ListTile of the provided survey information, with different interactions depending on published status
Widget _createSurveyListTile(Survey survey) {
  Widget _previewButton = _buttonWithLabel('Preview', Icons.remove_red_eye, () {});
  Widget _editButton = _buttonWithLabel('Edit', Icons.create, () {});
  Widget _publishButton = _buttonWithLabel('Publish', Icons.publish, () {});
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
        children: [
          survey.published ? _previewButton : _editButton,
          survey.published ? _resultsButton : _publishButton,
          _deleteButton
        ]
      )
    ]
  );
}

// Creates a ListTile of the provided survey information, with different interactions depending on published status
Widget _createResponseListTile(SurveyResponse response) {
  Widget _previewButton = _buttonWithLabel('Preview', Icons.remove_red_eye, () {});
  Widget _editButton = _buttonWithLabel('Edit', Icons.edit, () {});
  Widget _resultsButton = _buttonWithLabel('Results', Icons.table_chart, () {});

  Survey survey = getSurvey(id: response.surveyId);
  User author = getUser(id: survey.author);

  return ExpansionTile(
    title : Text(survey.title, 
      style: TextStyle(
        fontWeight: FontWeight.w600,
      )
    ),
    subtitle : Text('Created by: ${author.username}'),

    // Expands on tap to reveal additional options
    children : [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _previewButton,
          _editButton,
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