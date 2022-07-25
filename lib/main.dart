import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sprint2/logic/user_prefs.dart';
import 'package:sprint2/models/user_model.dart';
import 'package:sprint2/routes.dart';
import 'package:sprint2/screens/first_landing.dart';
import 'package:sprint2/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(const Sprint2());
}

class Sprint2 extends StatefulWidget {
  const Sprint2({Key? key}) : super(key: key);

  @override
  State<Sprint2> createState() => _Sprint2State();
}

class _Sprint2State extends State<Sprint2> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var userPreferences = UserPreferences();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Fredoka_One",
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: Routes.generateRoute,
      // home: const HomeScreen(),
      // home: const LoginPage(),
      // home: Onboarding(),
      home: FutureBuilder<HestaBitUser>(
        future: userPreferences.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return const Onboarding();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
