import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroAnimation extends StatelessWidget {
  const IntroAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenRouteFunction(
      curve: Curves.linear,
      backgroundColor: Theme.of(context).primaryColor,
      splash: Lottie.asset('assets/intro.json', repeat: false),
      splashTransition: SplashTransition.fadeTransition,
      // disableNavigation: true,
      duration: 1000,
      animationDuration: const Duration(seconds: 3),
      splashIconSize: 500,
      screenRouteFunction: () async {
        return '/loginRegister';
      },
    );
  }
}
