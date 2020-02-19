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
            child: QuestionPage(_currentQuestion)
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

class QuestionPage extends StatelessWidget {
  QuestionPage(this.question);
  final SurveyQuestion question;

  @override 
  Widget build(BuildContext context) {
    String questionText = this.question.text;

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(questionText),
          Column(
            children: this.question.choices.map((String choice) => Text(choice)).toList()
          )
        ]
      )
    );
  }
}