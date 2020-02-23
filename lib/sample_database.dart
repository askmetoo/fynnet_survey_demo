import 'package:fynnet_survey_demo/data_models.dart';

   final List<User> users = [
    User(username: 'test', password: 'test'),
    User(username: 'test1', password: 'test1'),
    User(username: 'test2', password: 'test2'),
    User(username: 'test3', password: 'test3'),
    User(username: 'test4', password: 'test4'),
    User(username: 'test5', password: 'test5'),
    User(username: 'test6', password: 'test6'),
    User(username: 'test7', password: 'test7'),
    User(username: 'test8', password: 'test8'),
    User(username: 'test9', password: 'test9'),
  ];

  final List<Survey> surveys = [
    Survey(
      title: 'Sample survey #1',
      author: users[0].id, 
      questions: [
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s1q1',
          text: 'What is the first letter of the alphabet?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s1q1', text: 'Alpha'), 
            SurveyQuestionChoice(questionId: 'sample_s1q1', text: 'Bravo'), 
            SurveyQuestionChoice(questionId: 'sample_s1q1', text: 'Charlie'), 
            SurveyQuestionChoice(questionId: 'sample_s1q1', text: 'Delta'), 
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s1q2',
          text: 'What is the second letter of the alphabet?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s1q2', text: 'Alpha'), 
            SurveyQuestionChoice(questionId: 'sample_s1q2', text: 'Bravo'), 
            SurveyQuestionChoice(questionId: 'sample_s1q2', text: 'Charlie'), 
            SurveyQuestionChoice(questionId: 'sample_s1q2', text: 'Delta'), 
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s1q3',
          text: 'What is the third letter of the alphabet?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s1q3', text: 'Alpha'), 
            SurveyQuestionChoice(questionId: 'sample_s1q3', text: 'Bravo'), 
            SurveyQuestionChoice(questionId: 'sample_s1q3', text: 'Charlie'), 
            SurveyQuestionChoice(questionId: 'sample_s1q3', text: 'Delta'), 
          ]
        ),
      ]
    ), 

    Survey(
      title: 'Sample Survey #2',
      author: users[1].id, 
      questions: [
        SurveyQuestion(SurveyQuestionType.radio,
        id: 'sample_s2q1',
          text: 'What is your name',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s2q1', text: 'Arthur'),
            SurveyQuestionChoice(questionId: 'sample_s2q1', text: 'Bedivere'),
            SurveyQuestionChoice(questionId: 'sample_s2q1', text: 'Lancelot'),
            SurveyQuestionChoice(questionId: 'sample_s2q1', text: 'Galahad'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s2q2',
          text: 'What is your quest',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s2q2', text: 'To seek the Holy Grail'),
            SurveyQuestionChoice(questionId: 'sample_s2q2', text: 'To bed the fairest maiden'),
            SurveyQuestionChoice(questionId: 'sample_s2q2', text: 'To slay the most fearsome beasts'),
            SurveyQuestionChoice(questionId: 'sample_s2q2', text: 'To travel to Camelot'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s2q3',
          text: 'What is your favorite color',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s2q3', text: 'Blue'),
            SurveyQuestionChoice(questionId: 'sample_s2q3', text: 'Green'),
            SurveyQuestionChoice(questionId: 'sample_s2q3', text: 'Red'),
            SurveyQuestionChoice(questionId: 'sample_s2q3', text: 'Yellow'),
          ]
        )
      ]
    ),

    Survey(
      title: 'Sample Survey #3',
      author: users[0].id, 
      questions: [
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s3q1',
          text: 'What is your birth gender?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s3q1', text: 'Male'),
            SurveyQuestionChoice(questionId: 'sample_s3q1', text: 'Female'),
            SurveyQuestionChoice(questionId: 'sample_s3q1', text: 'Other'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s3q2',
          text: 'What is your gender identity?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s3q2', text: 'Male'),
            SurveyQuestionChoice(questionId: 'sample_s3q2', text: 'Female'),
            SurveyQuestionChoice(questionId: 'sample_s3q2', text: 'Other'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s3q3',
          text: 'What is your sexual orientation?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s3q3', text: 'Heterosexual'),
            SurveyQuestionChoice(questionId: 'sample_s3q3', text: 'Homosexual'),
            SurveyQuestionChoice(questionId: 'sample_s3q3', text: 'Bisexual'),
            SurveyQuestionChoice(questionId: 'sample_s3q3', text: 'Asexual'),
            SurveyQuestionChoice(questionId: 'sample_s3q3', text: 'Other'),
          ]
        ),
        SurveyQuestion(SurveyQuestionType.radio,
          id: 'sample_s3q4',
          text: 'What is your romantic orientation?',
          choices: [
            SurveyQuestionChoice(questionId: 'sample_s3q4', text: 'Heteroromantic'),
            SurveyQuestionChoice(questionId: 'sample_s3q4', text: 'Homoromantic'),
            SurveyQuestionChoice(questionId: 'sample_s3q4', text: 'Biromantic'),
            SurveyQuestionChoice(questionId: 'sample_s3q4', text: 'Aromantic'),
            SurveyQuestionChoice(questionId: 'sample_s3q4', text: 'Other'),
          ]
        )
      ]
    ),

  ];

  final List<SurveyResponse> responses = [
    SurveyResponse(
      surveyId: surveys[0].id,
      userId: users[1].id,
      responses: {
        surveys[0].questions[0]: surveys[0].questions[0].choices[0],
        surveys[0].questions[1]: surveys[0].questions[1].choices[0],
        surveys[0].questions[2]: surveys[0].questions[2].choices[0],
      }
    ),
    SurveyResponse(
      surveyId: surveys[0].id,
      userId: users[2].id,
      responses: {
        surveys[0].questions[0]: surveys[0].questions[0].choices[2],
        surveys[0].questions[1]: surveys[0].questions[1].choices[1],
        surveys[0].questions[2]: surveys[0].questions[2].choices[0],
      }
    ),
    SurveyResponse(
      surveyId: surveys[1].id,
      userId: users[0].id,
      responses: {
        surveys[1].questions[0]: surveys[1].questions[0].choices[2],
        surveys[1].questions[1]: surveys[1].questions[1].choices[3],
        surveys[1].questions[2]: surveys[1].questions[2].choices[2],
      }
    ),
    SurveyResponse(
      surveyId: surveys[1].id,
      userId: users[2].id,
      responses: {
        surveys[1].questions[0]: surveys[1].questions[0].choices[0],
        surveys[1].questions[1]: surveys[1].questions[1].choices[2],
        surveys[1].questions[2]: surveys[1].questions[2].choices[1],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[2].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[0],
        surveys[2].questions[1]: surveys[2].questions[1].choices[0],
        surveys[2].questions[2]: surveys[2].questions[2].choices[0],
        surveys[2].questions[3]: surveys[2].questions[3].choices[4],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[1].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[2],
        surveys[2].questions[1]: surveys[2].questions[1].choices[2],
        surveys[2].questions[2]: surveys[2].questions[2].choices[2],
        surveys[2].questions[3]: surveys[2].questions[3].choices[0],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[3].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[0],
        surveys[2].questions[1]: surveys[2].questions[1].choices[0],
        surveys[2].questions[2]: surveys[2].questions[2].choices[2],
        surveys[2].questions[3]: surveys[2].questions[3].choices[0],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[4].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[1],
        surveys[2].questions[1]: surveys[2].questions[1].choices[1],
        surveys[2].questions[2]: surveys[2].questions[2].choices[0],
        surveys[2].questions[3]: surveys[2].questions[3].choices[0],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[5].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[0],
        surveys[2].questions[1]: surveys[2].questions[1].choices[0],
        surveys[2].questions[2]: surveys[2].questions[2].choices[0],
        surveys[2].questions[3]: surveys[2].questions[3].choices[0],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[6].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[0],
        surveys[2].questions[1]: surveys[2].questions[1].choices[0],
        surveys[2].questions[2]: surveys[2].questions[2].choices[0],
        surveys[2].questions[3]: surveys[2].questions[3].choices[1],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[7].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[1],
        surveys[2].questions[1]: surveys[2].questions[1].choices[1],
        surveys[2].questions[2]: surveys[2].questions[2].choices[0],
        surveys[2].questions[3]: surveys[2].questions[3].choices[1],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[8].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[1],
        surveys[2].questions[1]: surveys[2].questions[1].choices[0],
        surveys[2].questions[2]: surveys[2].questions[2].choices[3],
        surveys[2].questions[3]: surveys[2].questions[3].choices[2],
      }
    ),
    SurveyResponse(
      surveyId: surveys[2].id,
      userId: users[9].id,
      responses: {
        surveys[2].questions[0]: surveys[2].questions[0].choices[1],
        surveys[2].questions[1]: surveys[2].questions[1].choices[0],
        surveys[2].questions[2]: surveys[2].questions[2].choices[1],
        surveys[2].questions[3]: surveys[2].questions[3].choices[0],
      }
    ),
  ];

