import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sprint2/routes.dart';
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

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Fredoka_One",
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: Routes.generateRoute,
      home: const HomeScreen(),
    );
  }
}
