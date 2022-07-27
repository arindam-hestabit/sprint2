import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rive/rive.dart';
import 'package:sprint2/components/browser.dart';
import 'package:sprint2/logic/controllers/get_controller.dart';
import 'package:sprint2/logic/user_prefs.dart';
import 'package:sprint2/models/user_model.dart';
import 'package:sprint2/screens/login.dart';
import 'package:sprint2/standalones.dart';
import 'package:sprint2/widget/glass_card.dart';
import 'package:sprint2/widget/loading.dart';
import 'package:sprint2/widget/my_carousel.dart';
import 'package:sprint2/widget/show_qr.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController cardAnimationController;
  bool isSmall = false;

  BrowseMe browseMe = BrowseMe();
  final UserPreferences _userPreferences = UserPreferences();
  final UserController _userController = Get.find(tag: '_userController');

  @override
  void initState() {
    browseMe.addMenuItem(
      ChromeSafariBrowserMenuItem(
        id: 1,
        label: "HestaBit",
        action: (url, title) {},
      ),
    );

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

  logout() {
    HestaBitUser prevUser = _userController.getUser.value!;

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage(prevUser: prevUser)));
    _userPreferences.removeData();
    _userController.resetUser();
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
                  child: homeGlassCard(screenSize, getTime),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  GestureDetector listCard1(String label, dynamic icon, void Function() func,
      [double? iconSize]) {
    return GestureDetector(
      onTap: func,
      child: GlassCard(
        height: 50,
        borderRadius: BorderRadius.circular(16.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 3,
              child: Text(
                label,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: (icon is IconData)
                  ? Icon(
                      icon,
                      color: Colors.white,
                      size: iconSize ?? 24.0,
                    )
                  : icon,
            ),
          ],
        ),
      ),
    );
  }

  GlassCard homeGlassCard(Size screenSize, String Function() getTime) {
    List widgetList = <Widget>[
      listCard1("Update data  ", Icons.sync_rounded, () {
        setState(() {});

        getLoader(context);
        Future.delayed(
          const Duration(seconds: 4),
          () => Navigator.of(context).pop(),
        );
      }),
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/myaccount'),
              child: GlassCard(
                height: 110,
                borderRadius: BorderRadius.circular(16.0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(
                      child: Hero(
                        tag: 'AccountIcon',
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 36.0,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Hero(
                        tag: 'AccountText',
                        child: Text(
                          "My Account",
                          textScaleFactor: 1.3,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/myfriends'),
              child: GlassCard(
                height: 110,
                borderRadius: BorderRadius.circular(16.0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(
                      child: Hero(
                        tag: 'FriendIcon',
                        child: Icon(
                          Icons.people_rounded,
                          color: Colors.white,
                          size: 36.0,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Hero(
                        tag: 'FriendText',
                        child: Text(
                          "My Friends",
                          textScaleFactor: 1.3,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      listCard1("Explore Hestabit  ", Icons.arrow_right_alt_rounded,
          browseHestabit, 30.0),
      listCard1(
        "My QR identity  ",
        const ImageIcon(
          AssetImage('assets/icons/material-symbols_qr-code-rounded.png'),
          color: Colors.white,
        ),
        () => showMyQR(context, _userController.getUser.value!),
      ),
      listCard1("Login with different data  ", Icons.logout_rounded, logout),
    ];

    return GlassCard(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      borderRadius: BorderRadius.circular(30.0),
      child: (screenSize.height * 0.5 > screenSize.width)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    // cardAnimationController.value.toString(),
                    "Good \n${getTime()}",
                    textScaleFactor: 2.8,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyCarousel(),
                Expanded(
                  child: GlassCard(
                    height: double.infinity,
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    borderRadius: BorderRadius.circular(24.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ListView.separated(
                      itemBuilder: (context, index) => widgetList[index],
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 8.0),
                      itemCount: widgetList.length,
                    ),
                  ),
                ),
              ],
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

  void browseHestabit() async {
    Uri _url = Uri.parse("https://www.hestabit.com/");

    // Fluttertoast.showToast(msg: "Opening HestaBit!");

    getLoader(context);

    Future.delayed(
      const Duration(seconds: 2, milliseconds: 500),
      () async {
        Navigator.of(context).pop();

        if (Platform.isAndroid || Platform.isIOS) {
          browseMe.open(
            url: _url,
            options: ChromeSafariBrowserClassOptions(
              android: AndroidChromeCustomTabsOptions(
                shareState: CustomTabsShareState.SHARE_STATE_OFF,
              ),
              ios: IOSSafariOptions(
                barCollapsingEnabled: true,
              ),
            ),
          );
        } else {
          if (!await launchUrl(_url)) {
            throw 'Could not launch $_url';
          }
        }
      },
    );
  }

  @override
  void dispose() {
    cardAnimationController.dispose();
    super.dispose();
  }
}
