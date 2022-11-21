import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/login/login_screen.dart';
import 'package:todo_app/screens/addnewtask/addnewtaskscreen.dart';
import '../screens/all_tasks/alltaskscreen.dart';
import '../screens/completed_tasks/completedtaskscreen.dart';
import '../screens/home/homescreen.dart';
import '../screens/incomplete_tasks/incompletetaskscreen.dart';
import '../screens/signup/signupscreen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return HomeScreen.route();
    } else if (settings.name == HomeScreen.routeName) {
      return HomeScreen.route();
    } else if (settings.name == LoginScreen.routeName) {
      return LoginScreen.route();
    } else if (settings.name == SignupScreen.routeName) {
      return SignupScreen.route();
    } else if (settings.name == AlltasksScreen.routeName) {
      return AlltasksScreen.route();
    }else if (settings.name == CompletedtasksScreen.routeName) {
      return CompletedtasksScreen.route();
    }else if (settings.name == IncompletetasksScreen.routeName) {
      return IncompletetasksScreen.route();
    }else if (settings.name == AddnewtasksScreen.routeName) {
      return AddnewtasksScreen.route();}

    else {
      return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text('error'),
          ),
        ),
        settings: RouteSettings(name: '/error'));
  }
}


