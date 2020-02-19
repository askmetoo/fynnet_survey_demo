import 'package:flutter/material.dart';

import '../models/survey.dart';

class SurveyRespond extends StatefulWidget {

  // Specific survey being answered is fixed throughout widget lifetime
  SurveyRespond({Key key, this.survey}) : super(key: key);
  final Survey survey;

  @override
  _SurveyRespondState createState() => _SurveyRespondState();
}

class _SurveyRespondState extends State<SurveyRespond> {
  int _page;

  _SurveyRespondState() {
    this._page = 0;
  }

  @override
  Widget build(BuildContext context) {
    SurveyQuestion _currentQuestion = widget.survey.questions[_page];

    MaterialButton _backButton = RaisedButton(
      child: Text('Go Back'), 
      onPressed: () {
        setState(() { this._page--; });
      }
    );

    MaterialButton _nextButton = RaisedButton(
      child: Text('Continue'), 
      onPressed: () {
        setState(() { this._page++; });
      }
    );
    
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: QuestionPage(_currentQuestion, key: ObjectKey(_currentQuestion)) // Key to differentiate between different QuestionPages
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO: properly style buttons or implement better navigational scheme
              if (_page > 0) _backButton,
              if (_page < widget.survey.questions.length - 1) _nextButton,
            ]
          )
        ]
      )
    );

  }
}

class QuestionPage extends StatefulWidget {
  QuestionPage(this.question, {Key key}) : super(key: key);
  final SurveyQuestion question;

  @override
  State<StatefulWidget> createState() => _QuestionPageState(question);

}

class _QuestionPageState extends State<QuestionPage> {
  _QuestionPageState(this.question);
  final SurveyQuestion question;
  String _selection;

  Widget _radioSelectionBuilder(List<String> choices) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: choices.map((String choice) => 
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: choice,
                groupValue: _selection,
                onChanged: (String value) {
                  setState(() {
                    _selection = value;
                  });
                },
              ),
              Text(choice)
            ]
          )
        )
      ).toList()
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(this.question.text),
          _radioSelectionBuilder(this.question.choices)
        ]
      )
    );
  }
}