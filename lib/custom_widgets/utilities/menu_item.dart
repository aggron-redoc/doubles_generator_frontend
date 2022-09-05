import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MenuItems {

  final String text;
  final IconData icon;
  final Function() onTap;
  const MenuItems({
    required this.text, required this.icon, required this.onTap,
  });

  PopupMenuItem item() {
    return PopupMenuItem(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
            children: [
              WidgetSpan(child: Icon(icon,color: const Color(0xff25d050))),
              TextSpan(text: text,style: GoogleFonts.oswald(
                textStyle: const TextStyle(
                    color: Color(0xff25d050)
                )
              ))
            ]
        ),
      ),
    );
  }
}