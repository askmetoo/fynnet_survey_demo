import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/views/MainPage.dart';
import 'package:fynnet_survey_demo/views/PersonalPage.dart';
import 'package:fynnet_survey_demo/views/Respond.dart';
import 'package:fynnet_survey_demo/views/CreateSurvey.dart';

import 'package:fynnet_survey_demo/sample_database.dart' as SampleDatabase;

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
        '/respond' : (_) => SurveyRespond(surveyId: SampleDatabase.surveys[0].id),
        '/create' : (_) => EditSurvey(survey: SampleDatabase.surveys[0]),
      }
    );
  }
}