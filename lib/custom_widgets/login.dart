import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doubles_generator_frontend/custom_widgets/form_field_decoration.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class Login extends StatelessWidget {
  final String buttonText;
  final String headingText;
  final Function onPressed;
  Login(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      required this.headingText})
      : super(key: key);

  String tid = '', pwd = '';
  var isHidden = true.obs;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
            ),
            Text(
              headingText,
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                  textStyle:
                      const TextStyle(fontSize: 40, color: Color(0xff25d050))),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              style: GoogleFonts.oswald(
                textStyle: const TextStyle(
                  color: Color(0xff25d050),
                  letterSpacing: 2,
                ),
              ),
              decoration: generalInputDecorator("Group ID"),
              onSaved: (value) => tid = value!,
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(() => TextFormField(
                  obscureText: isHidden.value,
                  style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                      color: Color(0xff25d050),
                      letterSpacing: 2,
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: const Color(0xff25d050).withOpacity(0.35),
                      ),
                    ),
                    suffix: InkWell(
                      onTap: () => isHidden.value = !isHidden.value,
                      child: Icon((isHidden.value)
                          ? (Icons.visibility_off)
                          : (Icons.visibility)),
                    ),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onSaved: (value) => pwd = value!,
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: (){
                formkey.currentState!.save();
                if(buttonText=='Lets Play!') {
                  onPressed(tid,pwd,context);
                }
              },
              child: Text(
                buttonText,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(color: Color(0xff25d050)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
