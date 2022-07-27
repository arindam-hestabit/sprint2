// ignore_for_file: unused_local_variable

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rive/rive.dart';
import 'package:sprint2/database/my_firestore.dart';
import 'package:sprint2/logic/controllers/get_controller.dart';
import 'package:get/get.dart';
import 'package:sprint2/models/user_model.dart';
import 'package:sprint2/widget/glass_card.dart';
import 'package:sprint2/widget/hero_bot.dart';
import 'package:sprint2/widget/loading.dart';
import 'package:sprint2/widget/my_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFriends extends StatefulWidget {
  const MyFriends({Key? key}) : super(key: key);

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends>
    with SingleTickerProviderStateMixin {
  late AnimationController cardAnimationController;

  bool isSmall = false;
  bool bgTask = false;

  // final UserPreferences _userPreferences = UserPreferences();
  final UserController _userController = Get.find(tag: '_userController');

  RiveAnimationController safeBox = SimpleAnimation('Animation 1');

  final MyFirestore _firestore = MyFirestore();

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

  @override
  void initState() {
    cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  toggleCard() {
    setState(() {
      isSmall = !isSmall;
    });

    cardAnimationController.isDismissed
        ? cardAnimationController.forward()
        : cardAnimationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    addFriendPage() {
      final formKey = GlobalKey<FormState>();

      TextEditingController nameController = TextEditingController();
      TextEditingController phoneController = TextEditingController();
      TextEditingController mailController = TextEditingController();

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.blueGrey.shade100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: screenSize.height * 0.7),
        builder: (context) {
          return Form(
            key: formKey,
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
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

                List widgetsInScroll = [
                  const SizedBox(height: 8.0),
                  nameField(nameController),
                  phoneField(phoneController),
                  emailField(mailController),
                  deptField(),
                ];

                popAdd() => Navigator.of(context).pop();

                widgetsInScroll.add(
                  Center(
                    child: NeumorphicButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          getWaiter(context);

                          HestaBitFriend f = HestaBitFriend(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: mailController.text,
                            dept: deptsName[deptValue],
                          );

                          bool resp = await _firestore.addFriends(f);

                          popAdd();

                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              if (resp) {
                                Fluttertoast.showToast(
                                    msg: "Yay! Friends forever");

                                popAdd();
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Oops! unable to connect",
                                );
                              }
                            },
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please let me know your friend :)");
                        }
                      },
                      margin: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 15.0),
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
                              "Add me up",
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
                    ),
                  ),
                );

                widgetsInScroll.add(
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                );

                return Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: const EdgeInsetsDirectional.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 6.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: NeumorphicText(
                          "Hurray! \nMade new Friend",
                          textAlign: TextAlign.left,
                          style: const NeumorphicStyle(
                            color: Colors.black,
                            depth: 5.0,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontFamily: 'Fredoka_One',
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              widgetsInScroll[index],
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10.0),
                          itemCount: widgetsInScroll.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          (bgTask)
              ? SizedBox(
                  height: 150,
                  width: 150,
                  child: RiveAnimation.asset(
                    'assets/animations/milkshake_bomb.riv',
                    fit: BoxFit.fitWidth,
                    stateMachines: const ['Animation 1'],
                    controllers: [safeBox],
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              onPressed: () => addFriendPage(),
              backgroundColor: Colors.white.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: const Icon(
                Icons.add_reaction_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: cardAnimationController,
        builder: (context, w) {
          double scale = 1 - (0.25 * cardAnimationController.value);
          double translate = 220.0 * cardAnimationController.value;

          return Stack(
            children: [
              SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Image.asset(
                  'assets/images/gradienta-G084bO4wGDA-unsplash.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              (isSmall)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "${_userController.getUser.value!.name} \n@ HestaBit",
                            textScaleFactor: 2.8,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.maxFinite,
                  height: screenSize.width,
                  child: const RiveAnimation.asset(
                    'assets/animations/new_file.riv',
                    antialiasing: true,
                  ),
                ),
              ),
              SafeArea(
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(scale)
                    ..translate(translate),
                  alignment: Alignment.centerLeft,
                  child: friendGlassCard(screenSize),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  MyTextField emailField(mailController) => MyTextField(
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

  MyTextField phoneField(phoneController) => MyTextField(
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

  MyTextField nameField(nameController) => MyTextField(
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

  friendContent() {
    return FutureBuilder<List<Map>>(
      future: _firestore.getFriends(),
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "I know you have friends, \nadd 'em up here ...",
                textAlign: TextAlign.center,
                textScaleFactor: 1.1,
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.8,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          setState(() {
                            bgTask = true;
                          });

                          var resp = await _firestore.toggleFavourite(
                              snapshot.data![index]['id'],
                              !(snapshot.data![index]['data'].isFav));

                          setState(() {
                            bgTask = false;
                          });
                        },
                        autoClose: true,
                        label: (snapshot.data![index]['data'].isFav)
                            ? "UnFav"
                            : "Favourite",
                        icon: (snapshot.data![index]['data'].isFav)
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        borderRadius: BorderRadius.circular(15.0),
                        backgroundColor: Colors.lightGreen.shade200,
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          setState(() {
                            bgTask = true;
                          });

                          final bool resp = await _firestore
                              .deleteFriend(snapshot.data![index]['id']);

                          setState(() {
                            bgTask = false;
                          });

                          if (!resp) {
                            Fluttertoast.showToast(msg: "Sorry!");
                          }
                        },
                        autoClose: true,
                        label: "Unfriend",
                        icon: Icons.delete_rounded,
                        borderRadius: BorderRadius.circular(15.0),
                        backgroundColor: Colors.red.shade200,
                      ),
                    ],
                  ),
                  child: GlassCard(
                    height: 150,
                    padding: const EdgeInsets.all(8.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data![index]['data'].name,
                                        //"Arindam Karmakar",
                                        textScaleFactor: 1.5,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    if (snapshot.data![index]['data'].isFav)
                                      Flexible(
                                        child: Icon(
                                          Icons.star_rounded,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "Noida, India",
                                  // textScaleFactor: 1.5,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6)),
                                ),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    Uri url = Uri.parse(
                                        'tel:${snapshot.data![index]['data'].phone}');

                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: ImageIcon(
                                          const AssetImage(
                                              'assets/icons/Exclude(1).png'),
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Flexible(
                                        child: Text(
                                          snapshot.data![index]['data'].phone,
                                          // "8967331844",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    Uri url = Uri.parse(
                                        'mailto:${snapshot.data![index]['data'].email}');

                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: ImageIcon(
                                          const AssetImage(
                                              'assets/icons/Exclude.png'),
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Flexible(
                                        child: Text(
                                          snapshot.data![index]['data'].email,
                                          // "arindam.karmakar@hestabit.in",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GlassCard(
                          height: 150,
                          width: 30,
                          padding: const EdgeInsets.all(8.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(50.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Center(
                              child: Text(
                                snapshot.data![index]['data'].dept,
                                // "Development",
                                textScaleFactor: 0.85,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
              itemCount: snapshot.data!.length,
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else {
          return Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: RiveAnimation.asset(
                'assets/animations/milkshake_bomb.riv',
                fit: BoxFit.fitWidth,
                stateMachines: const ['Animation 1'],
                controllers: [safeBox],
              ),
            ),
          );
        }
      },
    );
  }

  friendGlassCard(screenSize) {
    return GlassCard(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      borderRadius: BorderRadius.circular(30.0),
      child: (screenSize.height * 0.7 > screenSize.width)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => toggleCard(),
                            icon: Icon(
                              (isSmall)
                                  ? Icons.north_west_rounded
                                  : Icons.south_east_rounded,
                            ),
                            color: Colors.white.withOpacity(0.6),
                            //padding: EdgeInsets.zero,
                            iconSize: 28.0,
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.keyboard_backspace_rounded,
                            ),
                            color: Colors.white.withOpacity(0.6),
                            //padding: EdgeInsets.zero,
                            iconSize: 28.0,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => getHeroBot(context),
                        child: GlassCard(
                          height: 50.0,
                          width: 50.0,
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(10.0),
                          borderRadius: BorderRadius.circular(50.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Icon(
                            Icons.bubble_chart_rounded,
                            color: Colors.white.withOpacity(0.5),
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Hero(
                          tag: 'FriendIcon',
                          child: Icon(
                            Icons.people_rounded,
                            color: Colors.white.withOpacity(0.6),
                            size: 50.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Flexible(
                        child: Hero(
                          tag: 'FriendText',
                          child: Text(
                            "My Friends",
                            textScaleFactor: 1.5,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GlassCard(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.only(top: 15.0),
                      padding: const EdgeInsets.all(15.0),
                      borderRadius: BorderRadius.circular(30.0),
                      child: friendContent(),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
                "This view is not yet supported, please return to portrait view! \nArindam Karmakar",
                textScaleFactor: 1.3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    cardAnimationController.dispose();
    _userController.dispose();
    safeBox.dispose();
    super.dispose();
  }
}
