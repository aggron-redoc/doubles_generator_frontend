import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  final Function(String?) saver;
  final String placeholder;
  const PasswordField(
      {Key? key, required this.saver, required this.placeholder})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isHidden,
      cursorColor: const Color(0xff25d050),
      validator: (value) {
        var x = value!;
        if (x.isEmpty) {
          return 'Empty fields cannot be accepted';
        }
        return null;
      },
      style: GoogleFonts.oswald(
        textStyle: const TextStyle(
          color: Color(0xff25d050),
          letterSpacing: 2,
        ),
      ),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: GoogleFonts.oswald(
          textStyle: TextStyle(
            color: const Color(0xff25d050).withOpacity(0.35),
          ),
        ),
        suffix: InkWell(
          onTap: () => setState(() {
            _isHidden = !_isHidden;
          }),
          child:
              Icon((_isHidden) ? (Icons.visibility_off) : (Icons.visibility)),
        ),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onSaved: (value) => widget.saver(value),
    );
  }
}
