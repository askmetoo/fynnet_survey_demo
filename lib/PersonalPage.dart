import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,

      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: _tabs.map( (PersonalTab tab) => Tab(text: tab.title, icon: Icon(tab.icon)) ).toList()
          ),
        ),
        body: TabBarView(
          children: _tabs.map((PersonalTab tab) => tab.content).toList()
        ),
      ),
    );
  }
}

class PersonalTab {
  final String title;
  final IconData icon;
  final Widget content;
  PersonalTab({this.title, this.icon, this.content});
}

// Define the tabs that are shown in the PersonalPage
List<PersonalTab> _tabs = [
  PersonalTab(
    title: 'My Surveys',
    icon: Icons.comment,
    content: personalSurveyTab,
  ),
  PersonalTab(
    title: 'Answered Surveys',
    icon: Icons.check_box,
    content: personalAnsweredTab,
  )
];

// Define the content in each tab
Widget personalSurveyTab = Card(
  child: Text('Tab1')
);
Widget personalAnsweredTab = Card(
  child: Text('Tab2')
);