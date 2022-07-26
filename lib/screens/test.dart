import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint2/logic/controllers/get_controller.dart';
import 'package:sprint2/models/user_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  UserController c = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(c.getUser.value.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.setUser = HestaBitUser(
              name: 'name',
              id: 23,
              phone: 'phone',
              email: 'email',
              dept: 'dept');
        },
      ),
    );
  }
}
