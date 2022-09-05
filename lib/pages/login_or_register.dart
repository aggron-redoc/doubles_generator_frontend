import 'package:doubles_generator_frontend/Services/so_far.dart';
import 'package:doubles_generator_frontend/custom_widgets/login.dart';
import 'package:doubles_generator_frontend/custom_widgets/register.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/snackbar.dart';
import 'package:doubles_generator_frontend/router.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);
  final items = const <Widget>[
    Icon(
      Icons.login_rounded,
      size: 30,
    ),
    Icon(
      Icons.app_registration_rounded,
      size: 30,
    )
  ];
  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  var index = 0;
  void resultFromLogin(String tid, String pwd, BuildContext context) async {
    var serviceProvider = SoFar(
      groupid: tid,
      password: pwd,
      resource: 'randomize',
    );
    Map result = await serviceProvider.get();
    if (result["result"] == "OK") {
      final args={'groupid': tid, 'password':pwd,};
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteManager.doublesGenerator,arguments: args);
    } else {
      if (!mounted) return;
      snackbar(context, "Invalid Credentials!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: CurvedNavigationBar(
            color: Theme.of(context).hoverColor,
            backgroundColor: Colors.transparent,
            items: widget.items,
            index: index,
            height: 60,
            animationCurve: Curves.easeInOut,
            onTap: (index) => setState(() {
                  this.index = index;
                })),
        body: (index == 0)
            ? (Login(
                headingText: 'Lets Play!',
                buttonText: 'Lets Play!',
                onPressed: resultFromLogin,
              ))
            : (const Register()));
  }
}
// check the status of adding service tomorrow
