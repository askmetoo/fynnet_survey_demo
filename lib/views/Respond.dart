import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/data_interface.dart';

class SurveyRespond extends StatefulWidget {
  // Specific survey being answered is fixed throughout widget lifetime
  SurveyRespond({Key key, this.survey}) : super(key: key);
  final Survey survey;

  @override
  _SurveyRespondState createState() => _SurveyRespondState();
}

class _SurveyRespondState extends State<SurveyRespond> {
  int _page; // current question
  SurveyResponse _response;

  _handleSubmit() async {
    print('submitting response: ${_response.responses}');
    if (addResponse(_response)) {
      await showDialog(context: context,
        builder: (context) => AlertDialog(title: Text('Submission successful'),
          content: Text('Your responses have been successfully recorded!'),
          actions: [
            RaisedButton(
              child: Text('Okay'), 
              onPressed: () => Navigator.of(context).pop()
            )
          ]
        )
      ).then((_) => Navigator.of(context).pop());
    }
  }

  @override // required to access widget object
  void initState() {
    this._page = 0;
    this._response = SurveyResponse(surveyId: widget.survey.id, userId: 'TODO'); // TODO: get userId from logged in user
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SurveyQuestion _currentQuestion = widget.survey.questions[_page];

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
      onPressed: this._page == 0 ? null : () {
        setState(() { this._page--; });
      }
    );

    MaterialButton _nextButton = _formControlButton('Continue',
      // disables button if no choice has been made for the current question
      onPressed: this._response.responses[_page] == null ? null : () {
        setState(() { this._page++; });
      }
    );

    MaterialButton _submitButton = _formControlButton('Submit',
      // enables button only if all questions have been responded
      onPressed: this._response.responses.any((String e) => e == null) ? null : () {
        _handleSubmit();
      }
    );

    Future<bool> _exitConfirmation() async {
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
    
    return WillPopScope(
      onWillPop: _exitConfirmation,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(child: Column(
          children: [
            Card(
              child: QuestionPage(_currentQuestion,
                currentSelection: this._response.responses[_page] ?? '', 
                //key: ObjectKey(_currentQuestion), // no need for key if stateless
                onChanged: (String id) => setState(() {
                  this._response.responses[_page] = id;
                })
              ) 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TODO: properly style buttons or implement better navigational scheme
                _backButton,
                _page < widget.survey.questions.length - 1 ? _nextButton : _submitButton,
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