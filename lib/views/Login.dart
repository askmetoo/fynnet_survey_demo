import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget{
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(24),

      children: [
        // Login Text
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text('Log in to save and customize your experience',
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

            validator: (String value) => value.isEmpty ? 'Username cannot be empty.' : null
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

            validator: (String value) => value.isEmpty ? 'Password cannot be empty.' : null
          )
        ),

        // Login Button
        Padding(
          padding: EdgeInsets.all(2.0),
          child: RaisedButton(
            child: Text('Log In'),
            color: Colors.green[700],
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
            onPressed: () {
              // TODO
              print('${_usernameController.text} | ${_passwordController.text}');
            }
          )
        )
      ],

    );
  }
}