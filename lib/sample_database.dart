import 'package:fynnet_survey_demo/data_models.dart';

   final List<User> users = [
    User(username: 'test', password: 'test'),
    User(username: 'test2', password: 'test2'),
  ];

  final List<Survey> surveys = [
    Survey(
      title: 'Sample survey #1',
      author: users[0].id, 
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
    ), 

    Survey(
      title: 'Sample Survey #2',
      author: users[1].id, 
      questions: [
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your name',
          choices: [
            SurveyQuestionChoice('Arthur'),
            SurveyQuestionChoice('Bedivere'),
            SurveyQuestionChoice('Lancelot'),
            SurveyQuestionChoice('Galahad'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your quest',
          choices: [
            SurveyQuestionChoice('To seek the Holy Grail'),
            SurveyQuestionChoice('To bed the fairest maiden'),
            SurveyQuestionChoice('To slay the most fearsome beasts'),
            SurveyQuestionChoice('To travel to Camelot'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your favorite color',
          choices: [
            SurveyQuestionChoice('Blue'),
            SurveyQuestionChoice('Green'),
            SurveyQuestionChoice('Red'),
            SurveyQuestionChoice('Yellow'),
          ]
        )
      ]
    )
  ];

  final List<SurveyResponse> responses = [];

