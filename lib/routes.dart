import 'package:flutter/material.dart';
import 'package:sprint2/screens/home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments;
    }

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());

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
