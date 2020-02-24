import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/data_interface.dart';
import 'package:fynnet_survey_demo/user_state.dart';

class SurveyRespond extends StatefulWidget {
  // Specific survey being answered is fixed throughout widget lifetime
  SurveyRespond({Key key, this.surveyId}) : super(key: key);
  final String surveyId;
  @override
  _SurveyRespondState createState() => _SurveyRespondState();
}

class _SurveyRespondState extends State<SurveyRespond> {
  Survey _survey;
  SurveyQuestion _currentQuestion;
  SurveyResponse _response;

  _handleSubmit() async {
    print('submitting response: ${_response.responses}');
    if (addResponse(_response)) {
      await showDialog(context: context,
        builder: (context) => AlertDialog(title: Text('Submission successful'),
          content: Text('Your responses have been successfully recorded!'),
          actions: [RaisedButton(
            child: Text('Okay'), 
            onPressed: () => Navigator.of(context).pop()
          )]
        )
      ).then((_) => Navigator.of(context).pop());
    } else {
      await showDialog(context: context,
        builder: (context) => AlertDialog(title: Text('Submission failed'),
          content: Text('Response unable to be added to database.'),
          actions: [RaisedButton(
            child: Text('Okay'), 
            onPressed: () => Navigator.of(context).pop()
          )]
        )
      );
    }
  }

  @override // required to access widget object
  void initState() {
    this._survey = getSurvey(id: widget.surveyId);
    this._currentQuestion = _survey.questions[0];
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    this._response = getResponse(
      surveyId: widget.surveyId,
      userId: UserInfo.of(context).user?.id 
    ) ?? SurveyResponse(
      surveyId: widget.surveyId, 
      userId: UserInfo.of(context).user?.id ?? 'guest-${uuid.v4()}'
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MaterialButton _formControlButton(String text, {Color color, Color textColor, @required Function onPressed}) {
      return RaisedButton(
        child: Text(text),
        color: color ?? Theme.of(context).primaryColor,
        textColor: textColor ?? Theme.of(context).secondaryHeaderColor,
        onPressed: onPressed,
      );
    }

    MaterialButton _backButton = _formControlButton('Go Back', 
      // disables button if user is on the first page
      onPressed: _currentQuestion == _survey.questions[0] ? null : () {
        setState(() { 
          int i = _survey.questions.indexOf(_currentQuestion) - 1; 
          _currentQuestion = _survey.questions[i];
        });
      }
    );

    MaterialButton _nextButton = _formControlButton('Continue',
      // disables button if no choice has been made for the current question
      onPressed: this._response.responses[_currentQuestion] == null ? null : () {
        setState(() { 
          int i = _survey.questions.indexOf(_currentQuestion) + 1; 
          _currentQuestion = _survey.questions[i];
        });
      }
    );

    MaterialButton _submitButton = _formControlButton('Submit',
      // enables button only if all questions have been responded
      onPressed: this._response.responses.length < this._survey.questions.length ? null : () {
        _handleSubmit();
      }
    );

    Future<bool> _exitConfirmation() async {
      if (this._response.responses.length == 0) {
        return true;
      } else {
        return await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Exiting this survey without submitting will discard all your changes!'),
            actions: [
              FlatButton(
                child: Text('Return to survey'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                color: Theme.of(context).errorColor,
                child: Text('Discard changes',
                  style: TextStyle(color: Theme.of(context).dialogBackgroundColor)
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }
              )
            ]
          )
        ) ?? false; // to deal with back button forcing dialog to return null
      }
    }
    
    return WillPopScope(
      onWillPop: _exitConfirmation,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(child: Column(
          children: [
            Card(
              child: QuestionPage(_currentQuestion,
                currentSelection: this._response.responses[_currentQuestion]?.id ?? '', 
                onChanged: (String choiceId) => setState(() {
                  this._response.responses[_currentQuestion] = this._currentQuestion.choices.firstWhere((c) => c.id == choiceId);
                })
              ) 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TODO: properly style buttons or implement better navigational scheme
                _backButton,
                _currentQuestion != this._survey.questions.last ? _nextButton : _submitButton,
              ]
            )
          ]
        )
      ))
    );

  }
}

class QuestionPage extends StatelessWidget {
  QuestionPage(this.question, {this.currentSelection, this.onChanged});
  final SurveyQuestion question;
  final String currentSelection;
  final Function onChanged; // callback for updating parent state based on selected value

  Widget _radioSelectionBuilder(List<SurveyQuestionChoice> choices) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: choices.map((SurveyQuestionChoice choice) => RadioListTile<String>(
          title: Text(choice.text),
          value: choice.id,
          groupValue: currentSelection,
          onChanged: onChanged,
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
          Padding(
            padding: EdgeInsets.fromLTRB(8, 15, 8, 20),
            child: Text(this.question.text, 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )
            )
          ),
          _radioSelectionBuilder(this.question.choices)
        ]
      )
    );
  }
}