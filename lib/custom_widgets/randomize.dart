import 'package:doubles_generator_frontend/custom_widgets/utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Randomize extends StatefulWidget {
  final Future<List<Widget>> Function({required bool activate}) randomizer;
  final Function() clear;
  const Randomize({Key? key, required this.randomizer, required this.clear})
      : super(key: key);

  @override
  State<Randomize> createState() => _RandomizeState();
}

class _RandomizeState extends State<Randomize> {

  late Future<List<Widget>> tournamentList;

  @override
  void initState() {
    super.initState();
    tournamentList = widget.randomizer(activate: false);
  }

  late List<Widget> matchUps;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>?>(
      future: tournamentList,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          snackbar(context, "Unforeseen error Occurred! Please Try Again!");
          setState(() {
            tournamentList = widget.randomizer(activate: false);
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
          matchUps = snapshot.data!;
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
                  itemCount: matchUps.length,
                  itemBuilder: (context, index) {
                    return matchUps[index];
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 90,
                      child: Divider(),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: ()  => setState(() {
                      tournamentList = widget.clear();
                    }),
                    child: Text(
                      "Clear",
                      style: GoogleFonts.oswald(
                        textStyle: const TextStyle(color: Color(0xff25d050)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => setState(() {
                            tournamentList = widget.randomizer(activate: true);
                          }),
                      child: Text(
                        "Randomize",
                        style: GoogleFonts.oswald(
                          textStyle: const TextStyle(color: Color(0xff25d050)),
                        ),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
