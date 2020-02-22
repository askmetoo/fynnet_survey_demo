import 'package:flutter/material.dart';

import 'package:fynnet_survey_demo/data_models.dart';
import 'package:fynnet_survey_demo/data_interface.dart';

class SurveyDataPage extends StatefulWidget {
  SurveyDataPage({this.surveyId, Key key}) : super(key: key);
  final String surveyId;

  @override
  State<SurveyDataPage> createState() => _SurveyDataPageState();
}

class _SurveyDataPageState extends State<SurveyDataPage> {
  Survey survey;
  List<SurveyResponse> responses;
  List<Map<String, int>> data;

  // TODO: have SurveyQuestionChoice also contain question id?
  Widget _buildQuestionResults(int index) {
    return Text('$index');
  }

  @override
  void initState() {
    this.survey = getSurvey(id: widget.surveyId);
    this.responses = getResponsesBySurvey(widget.surveyId).toList();
      
    this.data = survey.questions.map((q) => { for (SurveyQuestionChoice c in q.choices) c.id : 0 }).toList();

    // This iterates through *each* user and *each* question, with O(n*m) time!!
    // TODO: implement some sort of mapreduce for data aggregation
    this.responses.forEach((SurveyResponse userResponse) {
      userResponse.responses.asMap().forEach((int index, String choiceId) {
        this.data[index][choiceId]++;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Results')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: Text(this.survey.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600
              )
            )
          ),
          Divider(thickness: 2.0, indent: 12, endIndent: 12),
          for (int i = 0; i < survey.questions.length; i++) _buildQuestionResults(i)
          
        ]
      ),
    );
  }
}