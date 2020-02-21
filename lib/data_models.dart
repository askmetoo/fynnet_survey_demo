/* Defines the schemas of data that will be stored in a database */
import 'package:fynnet_survey_demo/data_interface.dart';

// For password hashing
import 'dart:convert';
import 'package:crypto/crypto.dart';


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

    this.questions = this.questions ?? <SurveyQuestion>[];
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

    this.choices = this.choices ?? <SurveyQuestionChoice>[];
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

/*
  User
*/
class User {
  String id;
  String username;
  Digest hash;

  List<Survey> createdSurveys;

  User({this.username, String password}) {
    this.id = uuid.v4();
    this.hash = generateHash(password, this.id);

    this.createdSurveys = <Survey>[];
  }
}

Digest generateHash(String password, String salt) {
  List<int> bytes = utf8.encode(password + salt);
  return sha256.convert(bytes);
}

/*
  SurveyResponse
*/
class SurveyResponse {
  String userId;
  String surveyId;

  Map<String,String> responses; // { SurveyQuestion.id : SurveyQuestionChoice.id }

  SurveyResponse({this.userId, this.surveyId}) {
    Survey survey = getSurvey(id: surveyId);
    this.responses = { for (SurveyQuestion q in survey.questions) q.id : null };
  }

  void addResponse(String questionId, String choiceId) {
    this.responses[questionId] = choiceId;
  }

  bool matchUser(String userId) {
    return this.userId == userId;
  }

  bool matchSurvey(String surveyId) {
    return this.surveyId == surveyId;
  }
}
