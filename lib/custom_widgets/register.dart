import 'package:doubles_generator_frontend/custom_widgets/login.dart';
import 'package:doubles_generator_frontend/custom_widgets/register_second_page.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late Widget _currPage = Login(
    key: GlobalKey(),
    headingText: 'Register',
    buttonText: 'Next',
    onPressed: nextPage,
  );
  void nextPage(String tid, String pwd, BuildContext context) {
    setState(() {
      ptid = tid;
      ppwd = pwd;
      _currPage = RegisterSecondPage(
        tid: ptid,
        pwd: ppwd,
        onPressed: prevPage,
      );
    });
  }

  void prevPage() {
    setState(() {
      _currPage = Login(
        key: GlobalKey(),
        headingText: 'Register',
        buttonText: 'Next',
        onPressed: nextPage,
      );
    });
  }

  String ptid = '', ppwd = '';

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position:
                Tween(begin: const Offset(-1.0, 0), end: const Offset(0.0, 0.0))
                    .animate(animation),
            child: child,
          );
        },
        child: _currPage);
  }
}
