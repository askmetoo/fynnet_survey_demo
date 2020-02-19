import 'package:flutter/material.dart';

import 'views/MainPage.dart';
import 'views/PersonalPage.dart';
import 'views/Respond.dart';

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
      home: MainPage(title: 'Survey App'),
      initialRoute: '/',
      routes: {
        '/account' : (_) => PersonalPage(title: 'Survey'),
        '/respond' : (_) => SurveyRespond(survey: sampleSurvey),
      }
    );
  }
}


Survey sampleSurvey = new Survey(
  title: 'Sample survey #1',
  questions: [
    SurveyQuestion(SurveyQuestionType.radio,
      text: 'What is the first letter of the alphabet?',
      choices: ['A', 'B', 'C', 'D']
    ),
    SurveyQuestion(SurveyQuestionType.radio,
      text: 'What is the second letter of the alphabet?',
      choices: ['A', 'B', 'C', 'D']
    ),
    SurveyQuestion(SurveyQuestionType.radio,
      text: 'What is the third letter of the alphabet?',
      choices: ['A', 'B', 'C', 'D']
    ),
  ]
);