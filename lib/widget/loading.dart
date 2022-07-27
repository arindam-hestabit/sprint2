import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void getLoader(BuildContext context) {
  RiveAnimationController safeBox = SimpleAnimation('Example');

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0.0),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
          child: RiveAnimation.asset(
            'assets/animations/safe_box_icon.riv',
            fit: BoxFit.fitHeight,
            stateMachines: const [
              'State Machine 1',
              'Idle',
              'Hover_In',
              'Hover_Out',
              'Pressed',
              'Example',
            ],
            controllers: [safeBox],
          ),
        ),
      );
    },
  );

  safeBox.dispose();
}

void getWaiter(BuildContext context) {
  RiveAnimationController safeBox = SimpleAnimation('Animation 1');

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
          child: RiveAnimation.asset(
            'assets/animations/milkshake_bomb.riv',
            fit: BoxFit.fitWidth,
            stateMachines: const ['Animation 1'],
            controllers: [safeBox],
          ),
        ),
      );
    },
  );

  safeBox.dispose();
}
