import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  double opacity = 0.0;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          opacity = 1.0;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: AnimatedOpacity(
            opacity: opacity,
            curve: Curves.bounceIn,
            duration: const Duration(seconds: 2),
            child: Image.asset(
              'assets/logo/Hestabit-Logo.png',
            ),
            onEnd: () => Future.delayed(
              const Duration(milliseconds: 500),
              () => Navigator.of(context).pushReplacementNamed('/login'),
            ),
          ),
        ),
      ),
    );
  }
}
