import 'package:flutter/material.dart';
import 'package:fynnet_survey_demo/data_models.dart';

class _UserInfoContainer extends InheritedWidget {
  // Data is your entire state. In our case just 'User' 
  final UserInfoState data;
   
  // You must pass through a child and your state.
  _UserInfoContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_UserInfoContainer old) => true;
}

class UserInfo extends StatefulWidget {
  final Widget child;
  final User user;

  UserInfo({ @required this.child, this.user});

  // Access user anywhere in the app with UserInfo.of(context).user
  static UserInfoState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_UserInfoContainer>().data;
  }
  
  @override
  UserInfoState createState() => new UserInfoState();
}

class UserInfoState extends State<UserInfo> {
  User user;

  void updateUser(User user) {
    setState(() {
      this.user = user;
    });
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _UserInfoContainer(
      data: this,
      child: widget.child,
    );
  }
}