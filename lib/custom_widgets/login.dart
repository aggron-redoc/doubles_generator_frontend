import 'package:doubles_generator_frontend/custom_widgets/utilities/general_field.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/password_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final String buttonText;
  final String headingText;
  final Function onPressed;
  const Login(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      required this.headingText})
      : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String tid = '', pwd = '';
  var _loading = false;
  void saveTid(String? value) {
    setState(() {
      tid = value!;
    });
  }

  void savePwd(String? value) {
    setState(() {
      pwd = value!;
    });
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
              ),
              Text(
                widget.headingText,
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                        fontSize: 40, color: Color(0xff25d050))),
              ),
              const SizedBox(
                height: 30,
              ),
              GeneralField(
                placeholder: 'Group ID',
                saver: saveTid,
              ),
              const SizedBox(
                height: 40,
              ),
              PasswordField(saver: savePwd, placeholder: 'Password'),
              const SizedBox(
                height: 30,
              ),
              (!_loading)
                  ? ElevatedButton(
                      onPressed: () async {
                        final isValid = formkey.currentState?.validate();
                        if (isValid!) {
                          formkey.currentState!.save();
                          setState(() {
                            _loading = !_loading;
                          });
                          await widget.onPressed(tid, pwd, context);
                          setState(() {
                            _loading = !_loading;
                          });
                        }
                      },
                      child: Text(
                        widget.buttonText,
                        style: GoogleFonts.oswald(
                          textStyle: const TextStyle(color: Color(0xff25d050)),
                        ),
                      ))
                  : const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
