import 'package:doubles_generator_frontend/Services/register.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/general_field.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/snackbar.dart';
import 'package:doubles_generator_frontend/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterSecondPage extends StatefulWidget {
  final String tid, pwd;
  final Function() onPressed;
  const RegisterSecondPage(
      {Key? key, required this.tid, required this.pwd, required this.onPressed})
      : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  List<String> playerNames = List.filled(4, '', growable: true);

  Future<void> registerProcess(BuildContext context) async {
    var serviceProvider = Register(
      groupid: widget.tid,
      password: widget.pwd,
      resource: 'add',
      players: playerNames,
    );
    var result = await serviceProvider.post();
    if (result["result"] == "OK") {
      final args={'groupid': widget.tid, 'password':widget.pwd};
      if (!mounted) {
        return;
      }
      snackbar(context, "Registration Successful");
      Navigator.pushReplacementNamed(context, RouteManager.doublesGenerator,arguments: args);
    } else {
      if (!mounted) {
        return;
      }
      snackbar(context, "GroupId already exists!!");
    }
  }

  void saver(int index, String? value) {
    setState(() {
      playerNames[index] = value!;
    });
  }

  void deleter() {
    setState(() {
      playerWidgets.removeLast();
      playerNames.removeLast();
    });
  }

  late List<Widget> playerWidgets = [
    SizedFormField(
      index: 0,
      saver: saver,
    ),
    SizedFormField(
      index: 1,
      saver: saver,
    ),
    SizedFormField(
      index: 2,
      saver: saver,
    ),
    SizedFormField(
      index: 3,
      saver: saver,
    )
  ];
  void adder() {
    setState(() {
      playerNames.add('');
      playerWidgets.add(SizedFormField(
        index: playerWidgets.length,
        saver: saver,
      ));
    });
  }

  final formkey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: playerNames.length,
                  itemBuilder: (context, index) {
                    return playerWidgets[index];
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 30,
                      child: Divider(),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: adder,
                    icon: const Icon(Icons.add_box_outlined),
                    iconSize: 50,
                  ),
                  IconButton(
                    onPressed: (playerWidgets.length > 4) ? deleter : () {},
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: const Color(0xff25d050).withOpacity(
                          (playerWidgets.length <= 4) ? (0.25) : (1)),
                    ),
                    iconSize: 50,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: widget.onPressed,
                    child: Text(
                      "Prev",
                      style: GoogleFonts.oswald(
                        textStyle: const TextStyle(color: Color(0xff25d050)),
                      ),
                    ),
                  ),
                  (!_loading)
                      ? ElevatedButton(
                          onPressed: () async {
                            final isValid = formkey.currentState?.validate();
                            if (isValid!) {
                              formkey.currentState!.save();
                              setState(() {
                                _loading = !_loading;
                              });
                              await registerProcess(context);
                              setState(() {
                                _loading = !_loading;
                              });
                            }
                          },
                          child: Text(
                            "Lets Play!",
                            style: GoogleFonts.oswald(
                              textStyle:
                                  const TextStyle(color: Color(0xff25d050)),
                            ),
                          ))
                      : const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SizedFormField extends StatelessWidget {
  final int index;
  final Function(int, String?) saver;
  const SizedFormField({
    Key? key,
    required this.index,
    required this.saver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: 200,
        child: GeneralField(
            saver: (value) => saver(index, value),
            placeholder: "Player ${index + 1}"));
  }
}
