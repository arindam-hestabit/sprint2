import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void getLoader(BuildContext context) {
  RiveAnimationController safeBox = SimpleAnimation('Example');

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: RiveAnimation.asset(
          'assets/animations/safe_box_icon.riv',
          fit: BoxFit.cover,
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
      );
    },
  );

  safeBox.dispose();
}
