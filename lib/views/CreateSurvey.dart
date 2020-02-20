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
      floatingActionButton: FlatButton(
        child: Text('Print survey'), 
        onPressed: () { 
          print('Title: ${widget.survey.title}, Question1: ${widget.survey.questions[0].text}, Choice A.1: ${widget.survey.questions[0].choices}'); 
        }
      ),
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
  TextEditingController _questionTitleController;

  @override
  void dispose() {
    _questionTitleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Creates controller and adds listener -- runs only once on widget creation
    _questionTitleController = new TextEditingController(text: widget.question.text);
    _questionTitleController.addListener(() {
      setState(() { widget.question.text = _questionTitleController.text; });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        key: widget.key,
        leading: Icon(Icons.reorder),
        title: Text(widget.question.text, style: TextStyle(fontWeight: FontWeight.w700)),
        trailing: Icon(Icons.edit),
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                  controller: _questionTitleController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                  ),
                ),

                // Editable field for each existing choice
                if (widget.question.choices != null) 
                  ...widget.question.choices.map(
                    (String choice) => EditSurveyQuestionChoice(choice)
                  ),
                
                // Blank editable field for creating a new choice
                EditSurveyQuestionChoice(null)
              ]
            )
          )
        ]
    );
  }
  
}

class EditSurveyQuestionChoice extends StatefulWidget {
  EditSurveyQuestionChoice(this.choice, {Key key}) : super(key: key);
  String choice;

  @override
  State<StatefulWidget> createState() => new _EditSurveyQuestionChoiceState();
}

class _EditSurveyQuestionChoiceState extends State<EditSurveyQuestionChoice> {
  // TODO: if choice is null, then the widget should add the new string to the list of choices
  // TODO: if choice becomes '', then delete the choice
  TextEditingController _choiceController;

  @override
  void dispose() {
    _choiceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _choiceController = TextEditingController(text: widget.choice);
    _choiceController.addListener(() {
      setState(() {
        widget.choice = _choiceController.text; //TODO: turn choice into an object so that we can pass in reference
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
      leading: Icon(Icons.radio_button_unchecked),
      title: TextFormField(
          controller: _choiceController,
          decoration: InputDecoration(
            //contentPadding: EdgeInsets.fromLTRB(10.0, 5, 10, 5),
            border: UnderlineInputBorder()
          )
        )
      )
    );

  }
}