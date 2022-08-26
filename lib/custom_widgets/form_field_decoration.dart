import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

InputDecoration generalInputDecorator(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: GoogleFonts.oswald(
      textStyle: TextStyle(
        color: const Color(0xff25d050).withOpacity(0.35),
      ),
    ),
    filled: true,
    fillColor: Colors.white10,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
