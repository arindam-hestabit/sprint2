import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sprint2/logic/controllers/get_controller.dart';
import 'package:sprint2/logic/user_prefs.dart';
import 'package:sprint2/models/user_model.dart';
import 'package:sprint2/widget/loading.dart';
import 'package:sprint2/widget/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final HestaBitUser? prevUser;

  const LoginPage({
    Key? key,
    this.prevUser,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  int deptValue = 0;

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

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    if (widget.prevUser != null) setPrev(widget.prevUser!);

    super.initState();
  }

  void setPrev(HestaBitUser u) {
    setState(() {
      nameController.text = u.name;
      phoneController.text = u.phone;
      mailController.text = u.email;
      idController.text = u.id.toString();
      deptValue = deptsName.indexOf(u.dept);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> inputFields = [
      nameField(),
      phoneField(),
      emailField(),
      idField(),
    ]
        .map((e) => Padding(padding: const EdgeInsets.all(8.0), child: e))
        .toList();

    List<Widget> formChildrens = [
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
    ];
    formChildrens.addAll(inputFields);
    formChildrens.addAll([
      deptField(),
      Center(child: submitButton()),
    ]);

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
                children: formChildrens,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final UserPreferences _userPreferences = UserPreferences();
  final UserController _userController = Get.find(tag: '_userController');

  Widget submitButton() {
    return NeumorphicButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          HestaBitUser user = HestaBitUser(
            name: nameController.text,
            id: int.parse(idController.text),
            phone: phoneController.text,
            email: mailController.text,
            dept: deptsName[deptValue],
          );

          _userPreferences.saveData(user);
          _userController.setUser = user;

          await Future.delayed(
            const Duration(milliseconds: 550),
            () => getLoader(context),
          );

          Future.delayed(
            const Duration(seconds: 2, milliseconds: 500),
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/home');
            },
          );
        } else {
          Fluttertoast.showToast(msg: "Please let me know you :)");
        }
      },
      margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
      style: NeumorphicStyle(
        color: Colors.blueGrey.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Flexible(
            child: Text(
              "LogIn to \nAwesomeness",
              textScaleFactor: 1.2,
            ),
          ),
          SizedBox(width: 30.0),
          Flexible(
            child: ImageIcon(
              AssetImage('assets/icons/Group 1(2).png'),
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget deptField() {
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

  MyTextField idField() => MyTextField(
        controller: idController,
        labelText: "ID",
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.length != 4) {
            return "Enter valid id number";
          } else {
            return null;
          }
        },
        prefixText: "HESTA - ",
      );

  MyTextField emailField() => MyTextField(
        controller: mailController,
        labelText: "E-mail",
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (!GetUtils.isEmail(value.toString())) {
            return "Enter valid E-mail id";
          } else {
            return null;
          }
        },
      );

  MyTextField phoneField() => MyTextField(
        controller: phoneController,
        labelText: "Phone",
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.length != 10 || value.isEmpty) {
            return "Enter valid phone number";
          } else {
            return null;
          }
        },
      );

  MyTextField nameField() => MyTextField(
        controller: nameController,
        labelText: "Name",
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your name";
          } else {
            return null;
          }
        },
      );
}
