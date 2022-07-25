import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:sprint2/components/browser.dart';
import 'package:sprint2/logic/get_logic.dart';
import 'package:sprint2/standalones.dart';
import 'package:sprint2/widget/glass_card.dart';
import 'package:sprint2/widget/loading.dart';
import 'package:sprint2/widget/my_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

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
                            "Arindam Karmakar \n@ HestaBit",
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

  GestureDetector listCard1(String label, IconData icon, void Function() func,
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
              child: Text(
                label,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: Icon(
                icon,
                color: Colors.white,
                size: iconSize ?? 24.0,
              ),
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
      listCard1("Explore Hestabit  ", Icons.arrow_right_alt_rounded,
          browseHestabit, 30.0),
    ];

    return GlassCard(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      borderRadius: BorderRadius.circular(30.0),
      child: (screenSize.height * 0.6 > screenSize.width)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Flexible(
                  child: MyCarousel(),
                ),
                Expanded(
                  flex: 2,
                  child: GlassCard(
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
