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
  int _page; // current question
  List<String> _selections; // list of answers the user has selected

  @override // required to access widget object
  void initState() {
    this._page = 0;
    this._selections = List(widget.survey.questions.length);
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
      onPressed: () {
        setState(() { this._page--; });
      }
    );

    MaterialButton _nextButton = _formControlButton('Continue',
      // disables button if no choice has been made for the current question
      onPressed: this._selections[_page] == null ? null : () {
        setState(() { this._page++; });
      }
    );

    MaterialButton _submitButton = _formControlButton('Submit',
    onPressed: () {}
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
                currentSelection: _selections[_page] ?? '', 
                //key: ObjectKey(_currentQuestion), // no need for key if stateless
                onChanged: (String value) => setState(() {
                  _selections[_page] = value;
                })
              ) 
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
      ))
    );

  }
}

class QuestionPage extends StatelessWidget {
  QuestionPage(this.question, {this.currentSelection, this.onChanged});
  final SurveyQuestion question;
  final String currentSelection;
  final Function onChanged; // callback for updating parent state based on selected value

  Widget _radioSelectionBuilder(List<String> choices) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: choices.map((String choice) => RadioListTile<String>(
          title: Text(choice),
          value: choice,
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