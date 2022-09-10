import 'package:doubles_generator_frontend/custom_widgets/utilities/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralField extends StatelessWidget {
  final Function(String?) saver;
  final String placeholder;
  const GeneralField({Key? key, required this.saver, required this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        var x = value!;
        if (x.isEmpty) {
          return 'Empty fields cannot be accepted';
        }
        return null;
      },
      cursorColor: const Color(0xff25d050),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      style: GoogleFonts.oswald(
        textStyle: const TextStyle(
          color: Color(0xff25d050),
          letterSpacing: 2,
        ),
      ),
      decoration: generalInputDecorator(placeholder),
      onSaved: (value) => saver(value),
    );
  }
}
