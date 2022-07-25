import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sprint2/widget/glass_card.dart';
import 'package:sprint2/widget/my_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController cardAnimationController;
  bool isSmall = false;

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

    String getTime() {
      var now = DateTime.now();

      if (now.hour >= 4 && now.hour < 12) {
        return "Morning";
      } else if (now.hour >= 12 && now.hour < 17) {
        return "Afternoon";
      } else if (now.hour >= 17 && now.hour < 22) {
        return "Evening";
      } else if (now.hour >= 22 && now.hour < 4) {
        return "Night";
      } else {
        return "Day";
      }
    }

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

  GlassCard homeGlassCard(Size screenSize, String Function() getTime) {
    return GlassCard(
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(2.0),
      borderRadius: BorderRadius.circular(30.0),
      child: (screenSize.height * 0.6 > screenSize.width)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                /*SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: GestureDetector(
                    //onTap: () => toggleCard(),
                    child: RiveAnimation.asset(
                      'assets/animations/switch_summer_demo.riv',
                      stateMachines: const [
                        'State Machine 1',
                        'Off',
                        'IdleOn',
                        'On',
                        'IdleOff',
                      ],
                      controllers: [a],
                      onInit: (a) {
                        /*toggleCard();
                        Future.delayed(const Duration(seconds: 1), () {
                          toggleCard();
                        });*/
                      },
                      alignment: Alignment.topLeft,
                    ),
                  ),
                ),*/
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

  @override
  void dispose() {
    cardAnimationController.dispose();
    super.dispose();
  }
}
