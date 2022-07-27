// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sprint2/screens/first_landing.dart';
import 'package:sprint2/screens/friends.dart';
import 'package:sprint2/screens/home.dart';
import 'package:sprint2/screens/login.dart';
import 'package:sprint2/screens/my_account.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments;
    }

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case '/onboarding':
        return MaterialPageRoute(builder: (context) => const Onboarding());

      case '/myaccount':
        return MaterialPageRoute(builder: (context) => const MyAccount());

      case '/myfriends':
        return MaterialPageRoute(builder: (context) => const MyFriends());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Entered wrong route, Please go back"),
            ),
          ),
        );
    }
  }
}
