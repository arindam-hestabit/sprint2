import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint2/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Fredoka_One",
      ),
      home: const HomeScreen(),
    );
  }
}
