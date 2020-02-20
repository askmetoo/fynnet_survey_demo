/* Defines the schemas of data that will be stored in a database */

// Tool for generating unique ids
import 'package:uuid/uuid.dart';
var uuid = Uuid();

/*
  Survey
*/
class Survey {
  String id;
  String author;
  String title;
  bool published;
  List<SurveyQuestion> questions;
  

  Survey({this.title, this.questions}) {
    this.id = uuid.v4();
    this.author = 'Author'; // TODO: get value from logged in user
    this.published = false;
  }

}

/*
  SurveyQuestion
*/
class SurveyQuestion {
  String id;
  SurveyQuestionType type;
  String text;

  List<SurveyQuestionChoice> choices;

  SurveyQuestion(this.type, {this.text = '', this.choices}) {
    this.id = uuid.v4();
    if (this.type == SurveyQuestionType.freeform && this.choices != null) {
      throw 'freeform questions do not have choices';
    }

    this.choices = this.choices ?? new List();
  }
}

/*
  SurveyQuestionChoice
*/
class SurveyQuestionChoice {
  String id;
  String text;

  SurveyQuestionChoice([this.text = '']) {
    this.id = uuid.v4();
  }
}

// Define survey question types
enum SurveyQuestionType {
  radio, checkbox, dropdown, freeform
}