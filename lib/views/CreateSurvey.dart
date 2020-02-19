import 'package:flutter/material.dart';

import '../models/survey.dart';

class EditSurvey extends StatefulWidget {
  EditSurvey({Key key, this.survey}) : super(key: key);
  final Survey survey;

  @override
  _EditSurveyState createState() => _EditSurveyState();
}

class _EditSurveyState extends State<EditSurvey> {
  
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleFieldController = new TextEditingController(text: widget.survey.title);

    TextFormField _titleField = TextFormField(
      controller: _titleFieldController,
      onEditingComplete: () {
        setState(() {
          widget.survey.title = _titleFieldController.text;
          print('New title is: ${widget.survey.title}'); //!
        });
      },

      style: TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: 'Survey Title',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: UnderlineInputBorder()
      )
    );

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _titleField,
          if (widget.survey.questions != null) Expanded(
            child: ListView(
              children: widget.survey.questions.map((SurveyQuestion q) => EditSurveyQuestion(q))?.toList()
            )
          )
        ]
      )
    );
  }
}

class EditSurveyQuestion extends StatelessWidget{
  EditSurveyQuestion(this.question);
  final SurveyQuestion question;

  @override
  Widget build(BuildContext context) {
    TextEditingController _questionTitleController = new TextEditingController(text: question.text);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _questionTitleController, 
              decoration: InputDecoration(
                labelText: 'Question',
              )
            ),
            if (question.choices != null) ...question.choices.map((String choice) => EditSurveyQuestionChoice(choice))
          ]
        )
      )
    );
  }
  
}

class EditSurveyQuestionChoice extends StatelessWidget {
  EditSurveyQuestionChoice(this.choice);
  final String choice;

  @override
  Widget build(BuildContext context) {
    TextEditingController _choiceController = new TextEditingController(text: choice);

    return ListTile(
      leading: Icon(Icons.radio_button_unchecked),
      title: Container( 
        height: 48,
        child: TextFormField(
          controller: _choiceController,
          
          decoration: InputDecoration(
            border: OutlineInputBorder()
          )
        )
      )
    );

  }
}