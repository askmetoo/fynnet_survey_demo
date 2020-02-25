import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fynnet_survey_demo/data_interface.dart';
import 'package:fynnet_survey_demo/data_models.dart';

class EditSurvey extends StatefulWidget {
  EditSurvey({Key key, this.surveyId}) : super(key: key);
  final String surveyId;

  @override
  _EditSurveyState createState() => _EditSurveyState();
}

class _EditSurveyState extends State<EditSurvey> {
  Survey survey;
  TextEditingController _titleFieldController;

  @override 
  void dispose() {
    _titleFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    this.survey = getSurvey(id: widget.surveyId);
    _titleFieldController = new TextEditingController(text: this.survey.title);
    _titleFieldController.addListener(() {
      print('title changed to ${_titleFieldController.text}');
      if (this.survey.title != _titleFieldController.text) {
        setState(() {
          this.survey.title = _titleFieldController.text;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _reorderQuestions(int oldIndex, int newIndex) {
      setState(() {
        if (newIndex > oldIndex) newIndex -= 1;
        final SurveyQuestion item = this.survey.questions.removeAt(oldIndex);
        this.survey.questions.insert(newIndex, item);
      });
    }
    void _addChoice() {
      setState(() { this.survey.questions.add(new SurveyQuestion(SurveyQuestionType.radio)); });
    }
    void _onPublish() {
      if (this.survey.isValid) {
        setState(() { this.survey.publish(); Navigator.of(context).pop(); });
      } else {
        showDialog(context: context, child: AlertDialog(
          title: Text('Survey not valid'),
          content: Text('Survey needs to have at least one question, with at least two choices each.'),
          actions: [
            FlatButton(
              child: Text('Continue editing'),
              onPressed: () { Navigator.of(context).pop(); }
            )
          ]
        ));
      }
    }
    void _onDelete() async {
      await showDialog<bool>(context: context, builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('This will delete the entire survey, with no way to bring it back.'),
        actions: [
          FlatButton(
            child: Text('Continue editing'),
            onPressed: () { Navigator.of(context).pop(false); }
          ),
          FlatButton(
            child: Text('Confirm deletion'),
            color: Theme.of(context).errorColor,
            textColor: Colors.white,
            onPressed: () { 
              this.survey.delete(); 
              Navigator.of(context).pop(true);
            }
          )
        ]
      )).then((bool pop) {
        if (pop) Navigator.of(context).pop();
      });
    }

    TextFormField _titleField = TextFormField(
      controller: _titleFieldController,

      style: TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: 'Survey Title',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: UnderlineInputBorder()
      )
    );

    MaterialButton _publishButton = RaisedButton(
      key: UniqueKey(),
      child: Row(children: [
        Icon(Icons.publish),
        Text('Publish')
      ]),
      color: Theme.of(context).primaryColorDark,
      textColor: Colors.white,
      onPressed: this.survey.title == '' || this.survey.title == null ? null : _onPublish
    );

    MaterialButton _deleteButton = RaisedButton(
      key: UniqueKey(),
      child: Row(children: [
        Icon(Icons.delete_forever),
        Text('Delete')
      ]),
      color: Theme.of(context).errorColor,
      textColor: Colors.white,
      onPressed: _onDelete
    );

    

    return Scaffold(
      appBar: AppBar(
        title: Text('Creating survey')
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addChoice
      ),

      persistentFooterButtons: <Widget>[
        _deleteButton,
        _publishButton,
      ],

      body: Column(
        children: [
          _titleField,
          if (this.survey.questions != null) Expanded(
            child: ReorderableListView(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
              children: 
                [
                  ...this.survey.questions.map((SurveyQuestion question) => 
                    EditSurveyQuestion(question, this, key: ValueKey(question.id)) // Key needed for reordering
                  )?.toList()
                ],
              onReorder: _reorderQuestions
            )
          ),
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

  /// Creates a new Choice object for new choices to be written to. 
  /// This will be added to the existing list of Choices in this Question
  void _createNewChoice() {
    this._newChoice = new SurveyQuestionChoice(questionId: widget.question.id);
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

  /// Opens up a confirmation dialog before deleting the question
  void _confirmDelete(SurveyQuestion question) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('You are deleting the question: \"${question.text}\"'),
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
                  widget.parent.survey.questions.remove(question);
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
        leading: Icon(Icons.reorder),
        title: widget.question.text == '' ?
          Text('<New question>', 
            style: TextStyle(
              fontWeight: FontWeight.w500, 
              fontStyle: FontStyle.italic, 
              color: Theme.of(context).disabledColor,
            )
          ) :
          Text(widget.question.text, 
            style: TextStyle(fontWeight: FontWeight.w700)
          ),
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (String value){
            switch(value) {
              case 'delete':
              _confirmDelete(widget.question);
              // left open for more options in the future
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
                // Field for question text
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
  TextEditingController _choiceController;

  /// Checks if the new choice should be added or deleted from the list of choices.
  /// 
  // parent required to redraw all choices, awkward data propagation
  // TODO: less spaghettified method? pass in callback instead? inherited widget?
  void _onChange(SurveyQuestion question, SurveyQuestionChoice choice, String newText) {
    void _addChoice() => widget.parent.setState(() {
      choice.text = newText;
      question.choices.add(choice);
      widget.parent._createNewChoice();
    });

    void _removeChoice() => widget.parent.setState(() {
      question.choices.remove(choice);
    });

    void _updateChoice() => widget.parent.setState(() {
      choice.text = newText;
    });
    
    if ((choice.text ?? '').isEmpty && newText.isNotEmpty) {
      print('Adding $newText to choices...');
      _addChoice();
    } else if (choice.text.isNotEmpty && newText.isEmpty) {
      print('Removing ${choice.text} from choices...');
      _removeChoice();
    } else if (choice.text.isNotEmpty && newText.isNotEmpty && choice.text != newText) {
      print('Updating ${choice.text} to $newText...');
      _updateChoice();
    } else {
      print('Doing nothing...');
    }
  }

  @override
  void dispose() {
    _choiceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('building choice: id ${widget.choice.id}, text \'${widget.choice.text}\'');
    _choiceController = TextEditingController(text: widget.choice.text);
    _choiceController.addListener(() {
      _onChange(widget.parent.widget.question, widget.choice, _choiceController.text);
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
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: UnderlineInputBorder()
          )
        )
      )
    );

  }
}