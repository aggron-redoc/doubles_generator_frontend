import 'package:doubles_generator_frontend/Services/so_far.dart';
import 'package:doubles_generator_frontend/custom_widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class LoginRegister extends StatelessWidget {
  LoginRegister({Key? key}) : super(key: key);
  var index = 0.obs;

  void resultFromLogin(String tid, String pwd, BuildContext context) async {
    var serviceProvider = SoFar(
      groupid: tid,
      password: pwd,
      resource: 'randomize',
    );
    Map result = await serviceProvider.get();
    if (result["result"] == "OK") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: const Text("Logged in Successfully",),
        margin: EdgeInsets.only(
            bottom: 20,
            right: 20,
            left: 20),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: const Text("Invalid Credentials",),
        margin: EdgeInsets.only(
            bottom: 20,
            right: 20,
            left: 20),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.login_rounded,
        size: 30,
      ),
      const Icon(
        Icons.app_registration_rounded,
        size: 30,
      )
    ];
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: Obx(() => CurvedNavigationBar(
            color: Theme.of(context).hoverColor,
            backgroundColor: Colors.transparent,
            items: items,
            index: index.value,
            height: 60,
            animationCurve: Curves.easeInOut,
            onTap: (index) => this.index.value = index)),
        body: ListView(
          children: [
            Obx(() => (index.value == 0)
                ? (Login(
                    headingText: 'Lets Play!',
                    buttonText: 'Lets Play!',
                    onPressed: resultFromLogin,
                  ))
                : (Login(
                    headingText: 'Register',
                    buttonText: 'Next',
                    onPressed: () {},
                  )))
          ],
        ));
  }
}
