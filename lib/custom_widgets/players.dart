import 'package:doubles_generator_frontend/custom_widgets/utilities/form_field_decoration.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/slidable_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Players extends StatefulWidget {
  final List<String> players;
  final Function(String) remove;
  final Function(String) adder;
  const Players({Key? key, required this.players, required this.remove, required this.adder,}) : super(key: key);

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  void adder(){
    setState(() {
      tiles.add(
          SizedBox(
            height: 80,
            width: 200,
            child: TextField(
              autofocus: true,
              style: GoogleFonts.oswald(
                textStyle: const TextStyle(
                  color: Color(0xff25d050),
                  letterSpacing: 2,
                ),
              ),
              decoration: generalInputDecorator("New player"),
              onSubmitted: (value) async=> widget.adder(value),
            ),
          )
      );
    });
  }
  List<Widget> tiles =[];
  @override
  Widget build(BuildContext context) {
    for(int i=0;i<widget.players.length;i++) {
      tiles.add(SlidableTile(player: widget.players[i], remove: widget.remove,));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 80
    ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                return tiles[index];
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 80,
                  child: Divider(),
                );
              },
            ),
          ),
          IconButton(
            onPressed: adder,
            icon: const Icon(Icons.add_box_outlined),
            iconSize: 50,
          ),
        ],
      ),
    );
  }
}
