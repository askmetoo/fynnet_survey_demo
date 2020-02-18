import 'package:flutter/material.dart';

import 'views/MainPage.dart';
import 'views/PersonalPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fynnet Survey App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainPage(title: 'Survey App'),
      initialRoute: '/',
      routes: {
        '/account' : (_) => PersonalPage(title: 'Survey')
      }
    );
  }
}
