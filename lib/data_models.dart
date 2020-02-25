/* Defines the schemas of data that will be stored in a database */
import 'package:flutter/widgets.dart';
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
  
  bool get isValid => this.title != '' && this.questions.length > 0 && this.questions.every((q) => q.isValid);
  void publish() => this.published = true;

  void delete() => removeSurvey(this);

  Survey({this.title, @required this.author, this.published, this.questions}) {
    this.id = uuid.v4();
    this.author = this.author;
    this.published = this.published ?? false;

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

  bool get isValid => this.text != '' && this.choices.length > 1 && this.choices.every((c) => c.isValid);

  SurveyQuestion(this.type, {this.text = '', this.choices, this.id}) {
    this.id = this.id ?? uuid.v4();
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
  String questionId;
  String text;

  bool get isValid => this.text != '';

  SurveyQuestionChoice({this.text = '', @required this.questionId}) {
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

  User({@required this.username, String password}) {
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

  Map<SurveyQuestion, SurveyQuestionChoice> responses;

  SurveyResponse({@required this.userId, @required this.surveyId, this.responses}) {
    this.responses = this.responses ?? Map<SurveyQuestion, SurveyQuestionChoice>();
  }

  bool matchUser(String userId) {
    return this.userId == userId;
  }

  bool matchSurvey(String surveyId) {
    return this.surveyId == surveyId;
  }
}

class DataPoint {
  final String text;
  int freq;

  DataPoint(this.text, [this.freq = 0]);

  void increment() {
    this.freq++;
  }
}

class DataSeries {
  SurveyQuestion question;
  List<DataPoint> series;

  int get length => series.length;
  int get total => series.map((d) => d.freq).reduce((a, b) => a + b);

  DataSeries({this.series, this.question}) {
    this.series = this.series ?? <DataPoint>[];
  }

  void addDataPoint(DataPoint dataPoint) {
    this.series.add(dataPoint);
  }

  DataPoint getDataPointByText(String text) {
    return this.series.firstWhere((DataPoint d) => d.text == text);
  }
}