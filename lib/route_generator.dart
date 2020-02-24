import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/views/MainPage.dart';
import 'package:fynnet_survey_demo/views/PersonalPage.dart';
import 'package:fynnet_survey_demo/views/Respond.dart';
import 'package:fynnet_survey_demo/views/CreateSurvey.dart';
import 'package:fynnet_survey_demo/views/SurveyDataPage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final Map args = settings.arguments;
  final String userId = args != null ? args['userId'] : null;
  final String surveyId = args != null ? args['surveyId'] : null;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => MainPage(title: 'Survey App', userId: userId)
      );
    case '/account':
      return MaterialPageRoute(
        builder: (_) => PersonalPage(title: 'My Account', userId: userId)
      );
    case '/respond':
      return MaterialPageRoute(
        builder: (_) => SurveyRespond(surveyId: surveyId, userId: userId)
      );
    case '/edit':
      return MaterialPageRoute(
        builder: (_) => EditSurvey(surveyId: surveyId)
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