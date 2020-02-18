import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog>{
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _signupAction = false;

  @override 
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(24),

      children: [
        // Log In / Sign Up Text
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text( _signupAction ? 'Sign up below to create your own surveys!' : 'Log in to save and customize your experience',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)
          )
        ),

        // Username Field
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextFormField(
            controller: _usernameController,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Username',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
            ),

            //validator: (String value) => value.isEmpty ? 'Username cannot be empty.' : null
          )
        ),

        // Password Field
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
            ),

            //validator: (String value) => value.isEmpty ? 'Password cannot be empty.' : null
          )
        ),

        // Login / Sign Up Button
        Padding(
          padding: EdgeInsets.all(2.0),
          child: RaisedButton(
            child: _signupAction ? Text('Sign Up') : Text('Log In'),
            color: Colors.green[700],
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
            onPressed: () {
              // TODO
              print('${_usernameController.text} | ${_passwordController.text}');
            }
          )
        ),

        // Toggle between Log In / Sign Up forms
        Padding(
          padding: EdgeInsets.all(2.0),
          child: FlatButton(
            child: _signupAction ? Text('Have an account? Log in here.') : Text('Sign up for an account'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
            onPressed: () {
              setState(() {
                // TODO: clear form
                _signupAction = !_signupAction;
              });
              
            }
          )
        )
      ],

    );
  }
}