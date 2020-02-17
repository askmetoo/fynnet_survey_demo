import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget username_field = TextField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final TextField password_field = TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final FlatButton login_button = FlatButton(
      child: Text('Log In'),
      color: Colors.green[700],
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      onPressed: () {}
    );

    return Container(
      child: Card(
        
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                margin: EdgeInsets.all(18),
                child: Text('Log in to track and customize your experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                  )
                )
              ),
              username_field,
              password_field,
              login_button
            ],
          )
        )
      )
    );
  }
}
