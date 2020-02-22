import 'package:fynnet_survey_demo/data_models.dart';

   final List<User> users = [
    User(username: 'test', password: 'test'),
    User(username: 'test2', password: 'test2'),
    User(username: 'test3', password: 'test3'),
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
    ),

    Survey(
      title: 'Sample Survey #3',
      author: users[0].id, 
      questions: [
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your birth gender?',
          choices: [
            SurveyQuestionChoice('Male'),
            SurveyQuestionChoice('Female'),
            SurveyQuestionChoice('Other'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your gender identity?',
          choices: [
            SurveyQuestionChoice('Male'),
            SurveyQuestionChoice('Female'),
            SurveyQuestionChoice('Other'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your sexual orientation?',
          choices: [
            SurveyQuestionChoice('Heterosexual'),
            SurveyQuestionChoice('Homosexual'),
            SurveyQuestionChoice('Bisexual'),
            SurveyQuestionChoice('Asexual'),
            SurveyQuestionChoice('Other'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          text: 'What is your romantic orientation?',
          choices: [
            SurveyQuestionChoice('Heteroromantic'),
            SurveyQuestionChoice('Homoromantic'),
            SurveyQuestionChoice('Biromantic'),
            SurveyQuestionChoice('Aromantic'),
            SurveyQuestionChoice('Other'),
          ]
        )
      ]
    ),

  ];

  final List<SurveyResponse> responses = [
    SurveyResponse(
      surveyId: surveys[0].id,
      userId: users[1].id,
      responses: [
        surveys[0].questions[0].choices[0].id,
        surveys[0].questions[1].choices[0].id,
        surveys[0].questions[2].choices[0].id,
      ]
    ),
    SurveyResponse(
      surveyId: surveys[0].id,
      userId: users[2].id,
      responses: [
        surveys[0].questions[0].choices[2].id,
        surveys[0].questions[1].choices[1].id,
        surveys[0].questions[2].choices[0].id,
      ]
    ),
    SurveyResponse(
      surveyId: surveys[1].id,
      userId: users[0].id,
      responses: [
        surveys[1].questions[0].choices[2].id,
        surveys[1].questions[1].choices[3].id,
        surveys[1].questions[2].choices[2].id,
      ]
    ),
    SurveyResponse(
      surveyId: surveys[1].id,
      userId: users[2].id,
      responses: [
        surveys[1].questions[0].choices[0].id,
        surveys[1].questions[1].choices[2].id,
        surveys[1].questions[2].choices[1].id,
      ]
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[2].id,
      responses: [
        surveys[2].questions[0].choices[0].id,
        surveys[2].questions[1].choices[0].id,
        surveys[2].questions[2].choices[0].id,
        surveys[2].questions[3].choices[2].id,
      ]
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[1].id,
      responses: [
        surveys[2].questions[0].choices[2].id,
        surveys[2].questions[1].choices[2].id,
        surveys[2].questions[2].choices[4].id,
        surveys[2].questions[3].choices[4].id,
      ]
    ),
  ];

