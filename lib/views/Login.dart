import 'package:flutter/material.dart';
import 'package:fynnet_survey_demo/data_interface.dart';
import 'package:fynnet_survey_demo/data_models.dart';

class LoginDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog>{
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _signupAction = false;
  bool _actionError = false;

  void _handleButtonPress() {
    User user = this._signupAction ?
      _signUpUser(username: _usernameController.text, password: _passwordController.text) :
      _logInUser(username: _usernameController.text, password: _passwordController.text);

    if (user != null) {
      setState(() { this._actionError = false; });
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/account', arguments: {'userId' : user.id});
    } else {
      setState(() { this._actionError = true; });
    }
  }

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

        // Text to display if there is an error
        if (this._actionError) Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            this._signupAction ? 
              'A user with the username \"${_usernameController}\" already exists!' :
              'Your username or password is incorrect. Please re-verify.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).errorColor,
              
            )
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

            // TODO: validation!
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
            onPressed: _handleButtonPress
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
                _usernameController.text = '';
                _passwordController.text = '';
                _signupAction = !_signupAction;
              });
            }
          )
        )
      ],

    );
  }
}

// returns the User only if both the username and password is correct, otherwise null
User _logInUser({String username, String password}) {
  User user = getUser(username: username);
  if (user == null) { // username not found
    return null;
  }
  if (user.hash == generateHash(password, user.id)) {
    return user;
  } else {
    return null;
  }
}

// returns null if a user with the same username is found
User _signUpUser({String username, String password}) {
  User newUser = User(username: username, password: password);
  if (addUser(newUser)) {
    return newUser;
  } else {
    return null;
  }
}