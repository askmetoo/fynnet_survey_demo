import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/views/MainPage.dart';
import 'package:fynnet_survey_demo/views/PersonalPage.dart';
import 'package:fynnet_survey_demo/views/Respond.dart';
import 'package:fynnet_survey_demo/views/CreateSurvey.dart';
import 'package:fynnet_survey_demo/views/SurveyDataPage.dart';

import 'package:fynnet_survey_demo/sample_database.dart' as SampleDatabase;

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => MainPage(title: 'Survey App')
      );
    case '/account':
      assert(args is String);
      return MaterialPageRoute(
        builder: (_) => PersonalPage(title: 'My Account', userId: args)
      );
    case '/respond':
      assert(args is String);
      return MaterialPageRoute(
        builder: (_) => SurveyRespond(surveyId: args)
      );
    case '/create':
      return MaterialPageRoute(
        builder: (_) => EditSurvey(survey: SampleDatabase.surveys[0])
      );
    case '/results':
      assert(args is String);
      return MaterialPageRoute(
        builder: (_) => SurveyDataPage(surveyId: args)
      );
    default:
      return errorRoute;
  }
}

Route<dynamic> errorRoute = MaterialPageRoute(
  builder: (_) => Text('Route not found!')
);