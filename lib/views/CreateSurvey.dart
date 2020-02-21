import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fynnet_survey_demo/data_models.dart';

class EditSurvey extends StatefulWidget {
  EditSurvey({Key key, this.survey}) : super(key: key);
  final Survey survey;

  @override
  _EditSurveyState createState() => _EditSurveyState();
}

class _EditSurveyState extends State<EditSurvey> {
  TextEditingController _titleFieldController;

  @override 
  void dispose() {
    _titleFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _titleFieldController = new TextEditingController(text: widget.survey.title);
    _titleFieldController.addListener(() {
      setState(() {
        widget.survey.title = _titleFieldController.text;
      });
    });
    super.initState();
  }

  // FIXME: once focused on textfield outside of ReorderableListView, one cannot unfocus by going to another textfield
  @override
  Widget build(BuildContext context) {
    TextFormField _titleField = TextFormField(
      controller: _titleFieldController,

      style: TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: 'Survey Title',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: UnderlineInputBorder()
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Creating survey')
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() { widget.survey.questions.add(new SurveyQuestion(SurveyQuestionType.radio)); });
        }
      ),

      body: Column(
        children: [
          _titleField,
          if (widget.survey.questions != null) Expanded(
            child: ReorderableListView(
              header: _titleField,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
              children: 
                widget.survey.questions.map((SurveyQuestion question) => 
                  EditSurveyQuestion(question, this, key: ValueKey(question.id)) // Key needed for reordering
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
  EditSurveyQuestion(this.question, this.parent, {Key key}) : super(key: key);
  final SurveyQuestion question;
  final _EditSurveyState parent;

  @override
  State<StatefulWidget> createState() => _EditSurveyQuestionState();
}

class _EditSurveyQuestionState extends State<EditSurveyQuestion> {
  TextEditingController _questionTitleController;
  SurveyQuestionChoice _newChoice;

  // Creates a new Choice object for new choices to be written to. 
  // This will be added to the existing list of Choices in this Question
  void _createNewChoice() {
    this._newChoice = new SurveyQuestionChoice();
  }

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
    _createNewChoice();

    super.initState();
  }

  // Opens up a confirmation dialog before deleting the question
  void _confirmDelete(SurveyQuestion question) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('You are deleting this question: \"${question.text}\"'),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Theme.of(context).errorColor,
              child: Text('Delete',
                style: TextStyle(color: Theme.of(context).dialogBackgroundColor)
              ),
              onPressed: () {
                widget.parent.setState(() {
                  widget.parent.widget.survey.questions.remove(question);
                });
                Navigator.of(context).pop();
              }
            )
          ]
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      child: ExpansionTile(
        key: PageStorageKey<String>(widget.question.id),
        //leading: Icon(Icons.reorder),
        title: widget.question.text == '' ?
          Text('<New question>', style: TextStyle(
            fontWeight: FontWeight.w500, 
            fontStyle: FontStyle.italic, 
            color: Theme.of(context).disabledColor,
          )) :
          Text(widget.question.text, style: TextStyle(fontWeight: FontWeight.w700)),
        trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onSelected: (String value){
                    switch(value) {
                      case 'delete':
                      _confirmDelete(widget.question);
                      // left open for more options
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: Theme.of(context).errorColor))
                    ),
                  ]
                ),
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                
                TextFormField(
                  key: PageStorageKey<String>(widget.question.id + '_field'),
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
                    (SurveyQuestionChoice choice) => EditSurveyQuestionChoice(choice, parent: this, key: PageStorageKey<String>(choice.id))
                  ),
                
                // Blank editable field for creating a new choice
                EditSurveyQuestionChoice(_newChoice, parent: this, key: PageStorageKey<String>(_newChoice.id))
              ]
            )
          )
        ]
      )
    );
  }
  
}

class EditSurveyQuestionChoice extends StatefulWidget {
  EditSurveyQuestionChoice(this.choice, {this.parent, Key key}) : super(key: key);
  final SurveyQuestionChoice choice;
  final _EditSurveyQuestionState parent;

  @override
  State<StatefulWidget> createState() => new _EditSurveyQuestionChoiceState();
}

class _EditSurveyQuestionChoiceState extends State<EditSurveyQuestionChoice> {
  FocusNode _focusNode;
  TextEditingController _choiceController;

  // Checks if the new choice should be added or deleted from the list of choices.
  void _onFocusChange(SurveyQuestion question, SurveyQuestionChoice choice, String newText) {
    // parent required to redraw all choices
    print('focus changed on widget id ${choice.id}');
    // TODO: less spaghettified method? pass in callback instead?
    widget.parent.setState(() {
      if ((choice.text ?? '').isEmpty && newText.isNotEmpty) {
        // add choice to list
        print('Adding $newText to choices...');
        choice.text = newText;
        question.choices.add(choice);
        // add new blank textfield
        widget.parent._createNewChoice();
      } else if (choice.text.isNotEmpty && newText.isEmpty) {
        // remove choice from list
        print('Removing ${choice.text} from choices...');
        question.choices.remove(choice);
      } else if (choice.text.isNotEmpty && newText.isNotEmpty && choice.text != newText) {
        // update choice with new text
        print('Updating ${choice.text} to $newText...');
        choice.text = newText;
      }
    });

  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('initializing choice: id ${widget.choice.id}, text \'${widget.choice.text}\'');
    _focusNode = FocusNode();
    _choiceController = TextEditingController(text: widget.choice.text);
    _focusNode.addListener(() {
      _onFocusChange(widget.parent.widget.question, widget.choice, _choiceController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      child: ListTile(
        leading: Icon(Icons.radio_button_unchecked),
        title: TextFormField(
          controller: _choiceController,
          focusNode: _focusNode,
          onEditingComplete: _focusNode.unfocus,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: UnderlineInputBorder()
          )
        )
      )
    );

  }
}