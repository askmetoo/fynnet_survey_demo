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
    Iterable<Survey> surveys = getSurveysFromUser(userId: userId ?? '');
    return surveys.length == 0 || userId == null ? 
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
    Iterable<SurveyResponse> responses = getResponsesByUser(userId ?? '');
    return responses.length == 0 || userId == null ? 
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
    void _editAction() => Navigator.of(context).pushNamed('/edit', arguments: {'surveyId': survey.id});
    void _publishAction() => survey.isValid ? 
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: Text('You won\'t be able to make any more changes after publishing'),
      actions: [
        FlatButton(
          child: Text('Cancel'),
          onPressed: () { Navigator.of(context).pop(); }
        ),
        FlatButton(
          child: Text('Confirm'),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () { 
            setState(() { survey.publish(); });
            Navigator.of(context).pop();
          }
        )
      ]
    )) : 
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Survey not valid'),
      content: Text('Survey cannot be published due to pending issues. '
        'Make sure that there is at least one question, with at least two choices each'),
      actions: [FlatButton(
        child: Text('Okay'),
        onPressed: () { Navigator.of(context).pop(); }
      )]
    ));
    void _resultsAction() => Navigator.of(context).pushNamed('/results', arguments: {'surveyId': survey.id});
    void _deleteAction() => showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: Text('This will permanently delete the survey'),
      actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () { Navigator.of(context).pop(); }
          ),
          FlatButton(
            child: Text('Confirm deletion'),
            color: Theme.of(context).errorColor,
            textColor: Colors.white,
            onPressed: () { 
              setState(() { survey.delete(); });
              Navigator.of(context).pop();
            }
          )
        ]
    ));

    Widget _editButton = _buttonWithLabel('Edit', Icons.create, _editAction);
    Widget _publishButton = _buttonWithLabel('Publish', Icons.publish, _publishAction);
    Widget _resultsButton = _buttonWithLabel('Results', Icons.table_chart, _resultsAction);
    Widget _deleteButton = _buttonWithLabel('Delete', Icons.delete, _deleteAction, color: Colors.red[700]);

    return ExpansionTile(
      title : Text(survey?.title == null || survey.title == '' ? '<Untitled Survey>' : survey.title, 
        style: TextStyle(
          fontWeight: FontWeight.w600,
        )
      ),
      subtitle : survey.published ?
        Text('Published', style: TextStyle(color: Colors.green)) :
        Text('Not published', style: TextStyle(color: Colors.red)),

      // Expands on tap to reveal additional options
      children : [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: survey.published ? 
            [ _resultsButton, _deleteButton ] : 
            [ _editButton, _publishButton, _deleteButton ]
        )
      ]
    );
  }

  // Creates a ListTile of the provided survey information, with different interactions depending on published status
  Widget _createResponseListTile(BuildContext context, SurveyResponse response) {
    void _editAction() => Navigator.of(context).pushNamed('/respond', arguments: {'surveyId': response.surveyId});
    void _resultsAction() => Navigator.of(context).pushNamed('/results', arguments: {'surveyId': response.surveyId});

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

    MaterialButton _logoutButton = FlatButton(
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      shape: StadiumBorder(
        side: BorderSide(color: Colors.white)
      ),
      child: Row(
        children: [
          Icon(Icons.exit_to_app),
          Padding(padding: EdgeInsets.all(2)),
          Text('Log Out')
        ]
      ),
      onPressed: () {
        Navigator.of(context).pop();
        UserInfo.of(context).updateUser(null);
      }
    );

    // Defining tabs in page
    List<PersonalTab> _tabs = [
      PersonalTab(
        title: 'My Surveys',
        icon: Icons.comment,
        content: Card(
          child: ListView(
            children: _createSurveysList(user?.id)
          )
        ),
      ),
      PersonalTab(
        title: 'Answered Surveys',
        icon: Icons.check_box,
        content: Card(
          child: ListView(
            children: _createResponsesList(user?.id)
          )
        ),
      )
    ];

    return DefaultTabController(
      length: _tabs.length,

      child: Scaffold(
        appBar: AppBar(
          title: Text('${user?.username}\'s Personal Page'),
          bottom: TabBar(
            tabs: _tabs.map( (PersonalTab tab) => Tab(text: tab.title, icon: Icon(tab.icon)) ).toList()
          ),
          actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: _logoutButton
          )
        ]
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

