import 'package:flutter/material.dart';
import 'package:sprint2/database/my_firestore.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var a = await MyFirestore().getFriends();

          setState(() {
            data = a.toString();
          });
        },
      ),
    );
  }
}
