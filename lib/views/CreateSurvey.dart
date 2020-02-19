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
            child: ReorderableListView(
              header: Text('hello'),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
              children: 
                widget.survey.questions.map((SurveyQuestion question) => 
                  EditSurveyQuestion(question,
                    key: UniqueKey()) // Key needed for reordering
                )?.toList(),
              onReorder: (int oldIndex, int newIndex) {
                setState( () {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final SurveyQuestion item = widget.survey.questions.removeAt(oldIndex);
                  widget.survey.questions.insert(newIndex, item);
                },
              );
          
              }
            )
          )
        ]
      )
    );
  }
}

class EditSurveyQuestion extends StatefulWidget{
  EditSurveyQuestion(this.question, {Key key}) : super(key: key);
  final SurveyQuestion question;

  @override
  State<StatefulWidget> createState() => _EditSurveyQuestionState();
}

class _EditSurveyQuestionState extends State<EditSurveyQuestion> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _questionTitleController = new TextEditingController(text: widget.question.text);

    Text _buildTitle() => Text(widget.question.text);
    _questionTitleController.addListener(_buildTitle);

    return Card(
      key: widget.key,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.reorder),
            TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
              controller: _questionTitleController, 
              decoration: InputDecoration(
                labelText: 'Question',
              ),
            ),

            if (widget.question.choices != null) 
              ...widget.question.choices.map(
                (String choice) => EditSurveyQuestionChoice(choice)
              ),
            
            EditSurveyQuestionChoice(null)
          ]
        )
      )
    );
  }
  
}

class EditSurveyQuestionChoice extends StatelessWidget {
  EditSurveyQuestionChoice(this.choice);
  final String choice;
  // TODO: if choice is null, then the widget should add the new string to the list of choices
  // TODO: if choice becomes '', then delete the choice

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
      leading: Icon(Icons.radio_button_unchecked),
      title: TextFormField(
          initialValue: choice,
          decoration: InputDecoration(
            //contentPadding: EdgeInsets.fromLTRB(10.0, 5, 10, 5),
            border: UnderlineInputBorder()
          )
        )
      )
    );

  }
}