import 'package:flutter/material.dart';
import 'package:fynnet_survey_demo/data_interface.dart';
import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/user_state.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  List<Widget> _createSurveysList(userId) {
    Iterable<Survey> surveys = getSurveysFromUser(userId: userId);
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
      surveys.map((Survey survey) => _createSurveyListTile(context, survey)).toList();
  } 
  List<Widget> _createResponsesList(userId) {
    Iterable<SurveyResponse> responses = getResponsesByUser(userId);
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
      responses.map((SurveyResponse response) => _createResponseListTile(context, response)).toList();
  } 

  // Creates a ListTile of the provided survey information, with different interactions depending on published status
  Widget _createSurveyListTile(BuildContext context, Survey survey) {
    void _previewAction() => {};
    void _editAction() => Navigator.of(context).pushNamed('/edit', arguments: {'surveyId': survey.id});
    void _publishAction() => setState(() { survey.publish(); });
    void _resultsAction() => Navigator.of(context).pushNamed('/results', arguments: {'surveyId': survey.id});
    void _deleteAction() => {};

    Widget _previewButton = _buttonWithLabel('Preview', Icons.remove_red_eye, _previewAction);
    Widget _editButton = _buttonWithLabel('Edit', Icons.create, _editAction);
    Widget _publishButton = _buttonWithLabel('Publish', Icons.publish, _publishAction);
    Widget _resultsButton = _buttonWithLabel('Results', Icons.table_chart, _resultsAction);
    Widget _deleteButton = _buttonWithLabel('Delete', Icons.cancel, _deleteAction, color: Colors.red[700]);

    return ExpansionTile(
      title : Text(survey.title ?? 'Untitled Survey', 
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
  Widget _createResponseListTile(BuildContext context, SurveyResponse response) {
    void _reviewAction() => Navigator.of(context).pushNamed('/review', arguments: {'surveyId': response.surveyId}); // TODO: implement review page
    void _editAction() => Navigator.of(context).pushNamed('/respond', arguments: {'surveyId': response.surveyId});
    void _resultsAction() => Navigator.of(context).pushNamed('/results', arguments: {'surveyId': response.surveyId});

    Widget _reviewButton = _buttonWithLabel('Review Answers', Icons.remove_red_eye, _reviewAction);
    Widget _editButton = _buttonWithLabel('Modify Answers', Icons.edit, _editAction);
    Widget _resultsButton = _buttonWithLabel('See Results', Icons.table_chart, _resultsAction);

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
            _reviewButton,
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

  @override
  Widget build(BuildContext context) {

    User user = UserInfo.of(context).user;

    // Defining tabs in page
    List<PersonalTab> _tabs = [
      PersonalTab(
        title: 'My Surveys',
        icon: Icons.comment,
        content: Card(
          child: ListView(
            children: _createSurveysList(user.id)
          )
        ),
      ),
      PersonalTab(
        title: 'Answered Surveys',
        icon: Icons.check_box,
        content: Card(
          child: ListView(
            children: _createResponsesList(user.id)
          )
        ),
      )
    ];

    return DefaultTabController(
      length: _tabs.length,

      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.username}\'s Personal Page'),
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

