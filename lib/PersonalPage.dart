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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'My Surveys',
                icon: Icon(Icons.clear),
              ),
              Tab(
                text: 'Answered Surveys',
                icon: Icon(Icons.check_box),
              ),
              //Tab()
            ]
          ),
        ),
        body: TabBarView(
          children: [
            Card(child:Text('Tab1')),
            Card(child:Text('Tab2')),
            //Card(),
          ]
        ),
      ),
    );
  }
}