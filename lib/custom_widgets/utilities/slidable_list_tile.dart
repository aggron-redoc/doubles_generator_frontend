import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';


class SlidableTile extends StatelessWidget {
  final String player;
  final Function(String) remove;
  const SlidableTile({Key? key, required this.player, required this.remove,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            icon: Icons.delete_outline,
            onPressed: (context) async => remove(player),
          )
        ],
      ),
      child: Text(
        player,
        textAlign: TextAlign.center,
        style: GoogleFonts.oswald(
            textStyle:
            const TextStyle(fontSize: 30, color: Color(0xff25d050))),
      ),
    );
  }
}
