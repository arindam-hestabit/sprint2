import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void getHeroBot(BuildContext context) {
  RiveAnimationController safeBox = SimpleAnimation('State Machine 1');

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.black.withOpacity(0.6),
        insetPadding: EdgeInsets.zero,
        child: Transform(
          transform: Matrix4.identity()..scale(0.7),
          alignment: Alignment.bottomLeft,
          child: RiveAnimation.asset(
            'assets/animations/hero_bot.riv',
            fit: BoxFit.fitHeight,
            stateMachines: const ['State Machine 1'],
            controllers: [safeBox],
          ),
        ),
      );
    },
  );

  safeBox.dispose();
}
