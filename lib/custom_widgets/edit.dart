import 'package:doubles_generator_frontend/custom_widgets/players.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/snackbar.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  final Future<Map<String,List>> Function() soFar;
  final Future<Map<String,List>> Function(String) remove;
  final Future<Map<String,List>> Function(String) adder;
  const Edit({Key? key, required this.soFar, required this.remove, required this.adder}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late Future<Map<String,List>> soFar;

  void remove(String player) async
  {
    setState(() {
      soFar=widget.remove(player);
    });
  }

  void adder(String player) async{
    setState(() {
      soFar=widget.adder(player);
    });
  }
  @override
  void initState() {
    super.initState();
    soFar = widget.soFar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String,List>?>(
        future: soFar,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            snackbar(context, "Unforeseen error Occurred! Please Try Again!");
            setState(() {
              soFar = widget.soFar();
            });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            var total = snapshot.data!;
            List<String> players = List<String>.from(total["players"]!);
            return Players(players:players,remove: remove,adder: adder,);
          }
          return Container();
        });
  }
}
