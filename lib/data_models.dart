/* Defines the schemas of data that will be stored in a database */
import 'package:flutter/widgets.dart';
import 'package:fynnet_survey_demo/data_interface.dart';

// For password hashing
import 'dart:convert';
import 'package:crypto/crypto.dart';

// Tool for generating unique ids
import 'package:uuid/uuid.dart';
var uuid = Uuid();

/// Represents a survey, including its [title], [author], and a list of [questions]
class Survey {
  String id;
  String author;
  String title;
  bool published;
  List<SurveyQuestion> questions;
  
  // Returns whether or not the whole survey is ready for publishing
  bool get isValid => this.title != '' && this.questions.length > 0 && this.questions.every((q) => q.isValid);

  /// Marks the survey as published
  void publish() => this.published = true;

  /// Deletes the survey from the database
  void delete() => removeSurvey(this);

  /// Returns whether or not the specified user has already answered this survey
  bool hasAnswered(String userId) => getResponse(surveyId: this.id, userId: userId) != null;

  Survey({this.title, @required this.author, this.published, this.questions}) {
    this.id = uuid.v4();
    this.author = this.author;
    this.published = this.published ?? false;

    this.questions = this.questions ?? <SurveyQuestion>[];
  }

}

/// Represents a single question within a survey, containing the [text] of the question and the [choices] available
// TODO: implement other types of questions: checkbox, freeform, etc.
class SurveyQuestion {
  String id;
  SurveyQuestionType type;
  String text;

  List<SurveyQuestionChoice> choices;

  /// Returns whether or not the question is ready for publishing
  bool get isValid => this.text != '' && this.choices.length > 1 && this.choices.every((c) => c.isValid);

  SurveyQuestion(this.type, {this.text = '', this.choices, this.id}) {
    this.id = this.id ?? uuid.v4();
    if (this.type == SurveyQuestionType.freeform && this.choices != null) {
      throw 'freeform questions do not have choices';
    }

    this.choices = this.choices ?? <SurveyQuestionChoice>[];
  }
}

/// Represents each individual option in a radio-type question
class SurveyQuestionChoice {
  String id;
  String questionId;
  String text;

  /// Returns whether or not the choice is ready to be published
  bool get isValid => this.text != '';

  SurveyQuestionChoice({this.text = '', @required this.questionId}) {
    this.id = uuid.v4();
  }
}

/// Define survey question types -- currently only radio is implemented
enum SurveyQuestionType {
  radio, checkbox, dropdown, freeform
}

/// Represents a user of the app. Stores the [username] and [passwordHash]
class User {
  String id;
  String username;
  Digest passwordHash;

  User({@required this.username, String password}) {
    this.id = uuid.v4();
    this.passwordHash = generateHash(password, this.id);
  }
}

Digest generateHash(String password, String salt) {
  List<int> bytes = utf8.encode(password + salt);
  return sha256.convert(bytes);
}

/// Represents a response given by a unique combination of [userId] and [surveyId]
class SurveyResponse {
  String userId;
  String surveyId;

  Map<SurveyQuestion, SurveyQuestionChoice> responses;

  SurveyResponse({@required this.userId, @required this.surveyId, this.responses}) {
    this.responses = this.responses ?? Map<SurveyQuestion, SurveyQuestionChoice>();
  }

  /// Returns whether or not the response is given by a specific user
  bool matchUser(String userId) {
    return this.userId == userId;
  }

  /// Returns whether or not the response is for a specific survey
  bool matchSurvey(String surveyId) {
    return this.surveyId == surveyId;
  }
}

/// Represents a single data point. For radio-type questions, this comprises of the [text] of the option and its [freq]
class DataPoint {
  final String text;
  int freq;

  DataPoint(this.text, [this.freq = 0]);

  void increment() {
    this.freq++;
  }
}

/// Represents a collection of [DataPoint]s that is connected to a single [question]
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