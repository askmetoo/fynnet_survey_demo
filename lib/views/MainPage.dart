import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/data_interface.dart';
import 'package:fynnet_survey_demo/user_state.dart';

import 'package:fynnet_survey_demo/views/Login.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Survey> surveys;
  TextEditingController _searchController;
  User user;

  Widget _buildSurveyList(List surveys) => Expanded(
    child: ListView.builder(
      itemCount: surveys.length,
      itemBuilder: (BuildContext context, int index) => _surveyListing(context, surveys[index]),
    )
  );

  // Creates a ListTile of provided survey object to be fed into a ListView
  ListTile _surveyListing(BuildContext context, Survey survey, [bool answered = false]) {
    return ListTile(
      title: Text(survey.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
         fontWeight: FontWeight.w700,
         color: answered ? Theme.of(context).disabledColor : Colors.black,
         decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
        )
      ),
      subtitle: Text('Created by: ${getUser(id: survey.author).username}',
       maxLines: 2,
       overflow: TextOverflow.ellipsis,
       style: TextStyle(
         color: answered ? Theme.of(context).disabledColor : Colors.black54,
         decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
       )
      ),
      leading: Icon(
       Icons.comment, 
       color: Theme.of(context).primaryColor,
      ),
      trailing: Icon(Icons.keyboard_arrow_right),

      onTap: () {
        Navigator.pushNamed(context, '/respond', arguments: {'surveyId': survey.id});
      }
    );
  }

  @override
  void initState() {
    this._searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.surveys = getSurveys();
    this.user = UserInfo.of(context).user;

    MaterialButton _accountButton = FlatButton(
      textColor: Colors.white,
      color: Colors.green,
      shape: StadiumBorder(
        side: BorderSide(color: Colors.white)
      ),
      child: Row(
        children: [
          Icon(Icons.person),
          this.user == null ? Text('Log In') : Text('${this.user.username}\'s Account')
        ]
      ),
      onPressed: () => this.user == null ? 
        showDialog(
          context: context, 
          builder: (BuildContext context) => new LoginDialog()
        ) : 
        Navigator.of(context).pushNamed('/account')
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: _accountButton
          )
        ]
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if(this.user == null) {
            showDialog(
              context: context, 
              builder: (BuildContext context) => LoginDialog()
            );
          } else {
            Survey newSurvey = Survey(author: this.user.id);
            addSurvey(newSurvey);
            Navigator.of(context).pushNamed('/edit', arguments: {'surveyId' : newSurvey.id});
          } 
        }
      ),

      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: 'Search for a survey',
                suffixIcon: Icon(Icons.search)
              )
            ), // TODO: add search functionality

            _buildSurveyList(surveys),

          ]
        )
      ),
    );
  }
}

