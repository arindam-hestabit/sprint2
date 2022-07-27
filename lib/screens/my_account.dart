import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sprint2/logic/controllers/get_controller.dart';
import 'package:get/get.dart';
import 'package:sprint2/widget/glass_card.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with SingleTickerProviderStateMixin {
  late AnimationController cardAnimationController;

  bool isSmall = false;

  // final UserPreferences _userPreferences = UserPreferences();
  final UserController _userController = Get.find(tag: '_userController');

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

    return Scaffold(
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
                  child: accountGlassCard(screenSize),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget accountContent() {
    var user = _userController.getUser.value!;
    List<Map> userMap = [
      {
        'id': "Name",
        'data': user.name,
      },
      {
        'id': "Phone",
        'data': user.phone,
      },
      {
        'id': "E-mail",
        'data': user.email,
      },
      {
        'id': "ID",
        'data': user.id,
      },
      {
        'id': "Department",
        'data': user.dept,
      },
      {
        'id': "Location",
        'data': user.location,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              userMap[index]['data'].toString(),
              textScaleFactor: 1.5,
              style: const TextStyle(color: Colors.white, letterSpacing: 1.5),
            ),
            subtitle: Text(
              userMap[index]['id'],
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: userMap.length,
      ),
    );
  }

  Widget accountGlassCard(screenSize) {
    return GlassCard(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      borderRadius: BorderRadius.circular(30.0),
      child: (screenSize.height * 0.5 > screenSize.width)
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
                        onTap: () {},
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
                          tag: 'AccountIcon',
                          child: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white.withOpacity(0.6),
                            size: 50.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Flexible(
                        child: Hero(
                          tag: 'AccountText',
                          child: Text(
                            "My Account",
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
                      padding: const EdgeInsets.all(2.0),
                      borderRadius: BorderRadius.circular(30.0),
                      child: accountContent(),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
                "This view is not yet supported, please return to portrait view! \nArindam Karmaklar",
                textScaleFactor: 1.3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
    );
  }
}
