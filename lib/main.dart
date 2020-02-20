import 'package:flutter/material.dart';

import 'views/MainPage.dart';
import 'views/PersonalPage.dart';
import 'views/Respond.dart';
import 'views/CreateSurvey.dart';

import 'models/survey.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fynnet Survey App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: MainPage(title: 'Survey App'),
      initialRoute: '/create',
      routes: {
        '/' : (_) => MainPage(title: 'Survey App'),
        '/account' : (_) => PersonalPage(title: 'Survey'),
        '/respond' : (_) => SurveyRespond(survey: sampleSurvey),
        '/create' : (_) => EditSurvey(survey: sampleSurvey),
      }
    );
  }
}


Survey sampleSurvey = new Survey(
  title: 'Sample survey #1',
  questions: [
    SurveyQuestion(SurveyQuestionType.radio,
      text: 'What is the first letter of the alphabet?',
      choices: [
        SurveyQuestionChoice('Alpha'), 
        SurveyQuestionChoice('Bravo'), 
        SurveyQuestionChoice('Charlie'), 
        SurveyQuestionChoice('Delta'), 
      ]
    ),
    SurveyQuestion(SurveyQuestionType.radio,
      text: 'What is the second letter of the alphabet?',
      choices: [
        SurveyQuestionChoice('Alpha'), 
        SurveyQuestionChoice('Bravo'), 
        SurveyQuestionChoice('Charlie'), 
        SurveyQuestionChoice('Delta'), 
      ]
    ),
    SurveyQuestion(SurveyQuestionType.radio,
      text: 'What is the third letter of the alphabet?',
      choices: [
        SurveyQuestionChoice('Alpha'), 
        SurveyQuestionChoice('Bravo'), 
        SurveyQuestionChoice('Charlie'), 
        SurveyQuestionChoice('Delta'), 
      ]
    ),
  ]
);