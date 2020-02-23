import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/sample_database.dart' as SampleDatabase;

User getUser({String id, String username}) {
  if (id != null && username == null) {
    return SampleDatabase.users.firstWhere((User user) => user.id == id, orElse: () => null);
  } else if (id == null && username != null) {
    return SampleDatabase.users.firstWhere((User user) => user.username == username, orElse: () => null);
  } else {
    throw 'Exactly one of id or username is required in getUser(...).';
  }
}

// adds the provided User to the database. returns false if username already exists
bool addUser(User user) {
  if (getUser(username: user.username) == null) {
    SampleDatabase.users.add(user);
    return true;
  } else {
    // username already exists in database
    return false;
  }
}

Survey getSurvey({String id}) {
  assert(id != null, 'The survey id needs to be provided in getSurvey(...)');
  return SampleDatabase.surveys.firstWhere((Survey survey) => survey.id == id, orElse: () => null);
}

List<Survey> getSurveys() {
  return SampleDatabase.surveys;
}

Iterable<Survey> getSurveysFromUser({String userId}) {
  assert(userId != null, 'The userId needs to be provided in getSurveyFromUser(...)');
  return SampleDatabase.surveys.where((Survey survey) => survey.author == userId);
}

// adds the provided Survey to the database. returns false if Survey already exists
bool addSurvey(Survey survey) {
  if (getSurvey(id: survey.id) == null) {
    SampleDatabase.surveys.add(survey);
    return true;
  } else {
    return false;
  }
}

SurveyResponse getResponse({String surveyId, String userId}) {
  if (surveyId == null || userId == null) {
    throw 'Both the surveyId and userId must be provided in getResponse';
  } else {
    return SampleDatabase.responses.firstWhere(
      (SurveyResponse response) => response.matchSurvey(surveyId) && response.matchUser(userId),
      orElse: () => null 
    );
  }
}

Iterable<SurveyResponse> getResponsesBySurvey(String surveyId) {
  return SampleDatabase.responses.where((SurveyResponse response) => response.matchSurvey(surveyId));
}

Iterable<SurveyResponse> getResponsesByUser(String userId) {
  return SampleDatabase.responses.where((SurveyResponse response) => response.matchUser(userId));
}

// adds the provided SurveyResponse to the database. returns false if SurveyResponse already exists
bool addResponse(SurveyResponse response) {
  if (getResponse(surveyId: response.surveyId, userId: response.userId) == null) {
    SampleDatabase.responses.add(response);
    return true;
  } else {
    return false;
  }
}

// Responses are assumed to be from the same survey.
List<DataSeries> createDataSeriesFromResponses(List<SurveyResponse> responses, {String surveyId}) {
  Survey survey = getSurvey(id: surveyId ?? responses[0].surveyId);
  //List<String> questionText = survey.questions.map((q) => q.text);
  return null;
}

