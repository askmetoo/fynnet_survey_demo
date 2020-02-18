/* Defines the schemas of data that will be stored in a database */

// Tool for generating unique ids
import 'package:uuid/uuid.dart';
var uuid = Uuid();

/*
    Survey:
    - id
    - title
    - author
    - published
*/
class Survey {
  String id;
  String author;
  String title;
  bool published;
  List<SurveyQuestion> questions;

  Survey() {
    this.id = uuid.v4();
    this.author = 'Author'; // TODO: get value from logged in user
    this.published = false;
  }
}

/*
  SurveyQuestion:
  - id
  - type
  - question
*/
class SurveyQuestion {
  String id;
  SurveyQuestionType type;
  String question;

  SurveyQuestion(this.type) {
    this.id = uuid.v4();
  }
}

// Define survey question types
enum SurveyQuestionType {
  radio, checkbox, dropdown, freeform
}
class RadioSurveyQuestion extends SurveyQuestion {
  RadioSurveyQuestion() : super(SurveyQuestionType.radio);
  List<_Choice> choices;
  _Choice selected;
}
class CheckboxSurveyQuestion extends SurveyQuestion {
  CheckboxSurveyQuestion() : super(SurveyQuestionType.checkbox);
  List<_Choice> choices;
  List<_Choice> selected;
}
class DropdownSurveyQuestion extends SurveyQuestion {
  DropdownSurveyQuestion() : super(SurveyQuestionType.dropdown);
  List<_Choice> choices;
  _Choice selected;
}
class FreeformSurveyQuestion extends SurveyQuestion {
  FreeformSurveyQuestion() : super(SurveyQuestionType.freeform);
  String response;
}

class _Choice {
  String text;
  bool selected;
}