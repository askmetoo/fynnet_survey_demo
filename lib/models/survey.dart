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

  List<String> choices;

  SurveyQuestion(this.type, {this.text, this.choices}) {
    this.id = uuid.v4();
    if (this.type == SurveyQuestionType.freeform && this.choices != null) {
      throw 'freeform questions do not have choices';
    }
  }
}

// Define survey question types
enum SurveyQuestionType {
  radio, checkbox, dropdown, freeform
}