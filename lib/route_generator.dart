import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/views/MainPage.dart';
import 'package:fynnet_survey_demo/views/PersonalPage.dart';
import 'package:fynnet_survey_demo/views/ResponsePage.dart';
import 'package:fynnet_survey_demo/views/EditSurveyPage.dart';
import 'package:fynnet_survey_demo/views/SurveyDataPage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final Map args = settings.arguments;
  final String surveyId = args != null ? args['surveyId'] : null;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => MainPage()
      );
    case '/account':
      return MaterialPageRoute(
        builder: (_) => PersonalPage()
      );
    case '/respond':
      return MaterialPageRoute(
        builder: (_) => ResponsePage(surveyId: surveyId)
      );
    case '/edit':
      return MaterialPageRoute(
        builder: (_) => EditSurveyPage(surveyId: surveyId)
      );
    case '/results':
      return MaterialPageRoute(
        builder: (_) => SurveyDataPage(surveyId: surveyId)
      );
    default:
      return errorRoute;
  }
}

Route<dynamic> errorRoute = MaterialPageRoute(
  builder: (_) => Text('Route not found!')
);