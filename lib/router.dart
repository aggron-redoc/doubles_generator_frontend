import 'package:doubles_generator_frontend/custom_widgets/intro.dart';
import 'package:doubles_generator_frontend/pages/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:doubles_generator_frontend/pages/generator.dart';
import 'package:page_transition/page_transition.dart';

class RouteManager {
  static const String intro = '/';
  static const String loginRegister = '/loginRegister';
  static const String doublesGenerator = '/doublesGenerator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return PageTransition(
          child: const IntroAnimation(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 350),
        );
      case loginRegister:
        return PageTransition(
          child: LoginRegister(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 350),
        );
      case doublesGenerator:
        return PageTransition(
          child: DoublesGenerator(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 350),
        );
      default:
        throw const FormatException("Route Not found!! Check Routes again");
    }
  }
}
