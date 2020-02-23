import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

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
  List<DataSeries> data;

  // TODO: have SurveyQuestionChoice also contain question id?
  Widget _buildQuestionResults(int index) {
    SurveyQuestion question = this.survey.questions[index];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(question.text),
            //Row(
            //  children: [
                SimpleBarChart(id: question.id, data: this.data[index])
            //  ]
            //)
          ]
        ),
      )
    );
  }

  @override
  void initState() {
    this.survey = getSurvey(id: widget.surveyId);
    this.responses = getResponsesBySurvey(widget.surveyId).toList();
    this.data = createDataSeriesFromResponses(this.responses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Results')
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
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
          //_buildQuestionResults(0)
          for (int i = 0; i < survey.questions.length; i++) _buildQuestionResults(i)
          
        ]
      ),
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  final DataSeries data;
  final String id;
  SimpleBarChart({this.data, this.id});

  @override
  Widget build(BuildContext context) {
    print(this.data);
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      child: Charts.BarChart([
        Charts.Series<DataPoint,String>(
          id: this.id,
          data: this.data.series,

          domainFn: (DataPoint d, int i) => d.text,
          measureFn: (DataPoint d, int i) => d.freq,
        ) 
      ])
    );
  }
}