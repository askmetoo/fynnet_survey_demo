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

  void _createNewSurvey() {
    print('creating new survey...');
    String userId = this.user?.id ?? UserInfo.of(context).user?.id;
    assert(userId != null);
    Survey newSurvey = Survey(author: userId);
    addSurvey(newSurvey);
    Navigator.of(context).pushNamed('/edit', arguments: {'surveyId' : newSurvey.id});
  }

  Widget _buildSurveyList(List surveys) => Expanded(
    child: ListView.builder(
      itemCount: surveys.length,
      itemBuilder: (BuildContext context, int index) => _surveyListing(context, 
        surveys[index], 
        userId: this.user?.id ?? UserInfo.of(context).user?.id
      ),
    )
  );

  // Creates a ListTile of provided survey object to be fed into a ListView
  ListTile _surveyListing(BuildContext context, Survey survey, {String userId}) {
    bool answered = userId == null ? false : survey.hasAnswered(userId);
    return ListTile(
      title: Text(survey.title ?? 'Untitled survey',
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
    _searchController.addListener(() {
      if (_searchController.text == '') {
        setState(() { this.surveys = getSurveys().where((Survey s) => s.published).toList(); });
      } else {
        setState(() {
          this.surveys = getSurveys()
            .where((Survey s) => s.published && 
              s.title.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
        });
      }
    });
    this.surveys = getSurveys().where((Survey s) => s.published).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.user = UserInfo.of(context).user;
    if (_searchController.text == '') {
      this.surveys = getSurveys().where((Survey s) => s.published).toList();
    }

    MaterialButton _accountButton = FlatButton(
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      shape: StadiumBorder(
        side: BorderSide(color: Colors.white)
      ),
      child: Row(
        children: [
          Icon(Icons.person),
          Padding(padding: EdgeInsets.all(2)),
          this.user == null ? Text('Log In') : Text('${this.user.username}')
        ]
      ),
      onPressed: () => this.user == null ? 
        showDialog(
          context: context, 
          builder: (BuildContext context) => LoginDialog(
            onSuccess: () => Navigator.of(context).pushNamed('/account')
          )
        ) : 
        Navigator.of(context).pushNamed('/account')
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey App'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: _accountButton
          )
        ]
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => this.user == null ?
          showDialog(
            context: context, 
            builder: (BuildContext context) => LoginDialog(onSuccess: this._createNewSurvey)
          ) : this._createNewSurvey()
      ),

      body: Center(
        child: Column(
          children: [

            // Search field for surveys
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: 'Search for a survey',
                suffixIcon: Icon(Icons.search)
              )
            ),

            // Render each survey in a list
            surveys.length == 0 ? Padding(
              padding: EdgeInsets.all(24),
              child: Text('No surveys found',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Theme.of(context).disabledColor)
              )
            ) : _buildSurveyList(surveys),

          ]
        )
      ),
    );
  }
}

