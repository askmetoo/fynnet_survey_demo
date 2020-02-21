import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/data_interface.dart';

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

  @override
  void initState() {
    this.surveys = getSurveys();
    this._searchController = TextEditingController();
    super.initState();
  }

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

Widget _buildSurveyList(List surveys) => Expanded(
  child: ListView.builder(
    itemCount: surveys.length,
    itemBuilder: (BuildContext context, int index) => _surveyListing(context, surveys[index]),
  )
);

// Creates a ListTile of provided survey object to be fed into a ListView
ListTile _surveyListing(BuildContext context, Survey survey, [bool answered = false]) {
  final String title = survey.title;
  return ListTile(
    title: Text(survey.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: answered ? Colors.grey : Colors.black,
        decoration: answered ? TextDecoration.lineThrough : TextDecoration.none,
      )
    ),
    subtitle: Text('Created by: ${survey.author}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
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
      Navigator.pushNamed(context, '/respond', arguments: survey.id);
    }
  );
}