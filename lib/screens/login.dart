import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  int deptValue = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: NeumorphicText(
                      "Let's \nget started",
                      textAlign: TextAlign.left,
                      style: const NeumorphicStyle(
                        color: Colors.black,
                        depth: 5.0,
                      ),
                      textStyle: NeumorphicTextStyle(
                        fontFamily: 'Fredoka_One',
                        fontSize: 36.0,
                      ),
                    ),
                  ),
                  nameField(),
                  phoneField(),
                  emailField(),
                  idField(),
                  deptField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget deptField() {
    List<String> deptsName = [
      'Development',
      'Human Resource',
      'Management',
      'IT',
      'Finance',
      'Operations',
      'Business',
      'Marketing',
      'Designing',
      'Food',
    ];

    List<Widget> depts = [
      for (int i = 0; i < deptsName.length; i++)
        NeumorphicCheckbox(
          value: deptValue == i,
          onChanged: (data) {
            setState(() {
              deptValue = i;
            });
          },
        ),
    ];

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: depts
              .map((e) => Row(
                    children: [
                      e,
                      const SizedBox(width: 8.0),
                      Text(deptsName[depts.indexOf(e)]),
                      const SizedBox(width: 18.0),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  Padding idField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: idController,
        decoration: InputDecoration(
          prefixText: "HESTA - ",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade700,
            ),
          ),
          labelText: "ID",
        ),
        keyboardType: TextInputType.number,
        enableInteractiveSelection: true,
        maxLines: 1,
        validator: (value) {
          if (value == null || value.length != 4) {
            return "Enter valid id number";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Padding emailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: mailController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade700,
            ),
          ),
          labelText: "E-mail",
        ),
        keyboardType: TextInputType.emailAddress,
        enableInteractiveSelection: true,
        maxLines: 1,
        validator: (value) {
          if (!GetUtils.isEmail(value.toString())) {
            return "Enter valid E-mail id";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Padding phoneField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: phoneController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade700,
            ),
          ),
          labelText: "Phone",
        ),
        keyboardType: TextInputType.phone,
        enableInteractiveSelection: true,
        maxLines: 1,
        validator: (value) {
          if (value == null || value.length != 10 || value.isEmpty) {
            return "Enter valid phone number";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Padding nameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.blue.shade700,
            ),
          ),
          labelText: "Name",
        ),
        keyboardType: TextInputType.name,
        enableInteractiveSelection: true,
        maxLines: 1,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your name";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
