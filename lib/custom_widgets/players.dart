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
  late Widget body=playerList();
  void adder(){
    setState(() {
      body=addPlayer();
    });
  }

  TextField addPlayer() {
    return TextField(
      autofocus: true,
      cursorColor: const Color(0xff25d050),
      style: GoogleFonts.oswald(
        textStyle: const TextStyle(
          color: Color(0xff25d050),
          letterSpacing: 2,
        ),
      ),
      decoration: generalInputDecorator("New player"),
      onSubmitted: (value) async=> widget.adder(value),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 60
    ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: body,
      ),
    );
  }

  Column playerList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: widget.players.length,
            itemBuilder: (context, index) {
              return SlidableTile(player: widget.players[index], remove: widget.remove);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 40,
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
    );
  }
}
