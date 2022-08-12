import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[const Icon(Icons.login_rounded,size: 30,),const Icon(Icons.app_registration_rounded,size: 30,)];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).hoverColor,
        backgroundColor: Colors.transparent,
        items: items,
        index: index,
        height: 60,
        animationCurve: Curves.easeInOut,
        onTap: (index)=>setState(()=>this.index=index),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset('assets/logo.png',height: 500,width: 500,),
              Form(child: null,

              )
          ],
        ),
      ),
    );
  }
}

