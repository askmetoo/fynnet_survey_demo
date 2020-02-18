import 'package:flutter/material.dart';

// Various widgets to construct a login dialog
class Login {
  static final Widget loginText = Padding(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Text('Log in to save and customize your experience',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)
    )
  );

  static final Widget usernameField = Padding(
    padding: EdgeInsets.all(2.0),
    child: TextField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    )
  );

  static final Widget passwordField = Padding(
    padding: EdgeInsets.all(2.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    )
  );

  static final Widget loginButton = Padding(
    padding: EdgeInsets.all(2.0),
    child: FlatButton(
      child: Text('Log In'),
      color: Colors.green[700],
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {}
    )
  );
}
