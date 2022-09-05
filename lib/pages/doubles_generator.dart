import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doubles_generator_frontend/Services/add.dart';
import 'package:doubles_generator_frontend/Services/clear.dart';
import 'package:doubles_generator_frontend/Services/delete_account.dart';
import 'package:doubles_generator_frontend/Services/randomize.dart';
import 'package:doubles_generator_frontend/Services/so_far.dart';
import 'package:doubles_generator_frontend/custom_widgets/edit.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/menu_item.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/snackbar.dart';
import 'package:doubles_generator_frontend/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doubles_generator_frontend/custom_widgets/randomize.dart' as randomize_widget;
import 'package:doubles_generator_frontend/Services/remove_player.dart';

class DoublesGenerator extends StatefulWidget {
  final String tid, pwd;
  const DoublesGenerator({Key? key, required this.tid, required this.pwd})
      : super(key: key);
  final items = const <Widget>[
    Icon(
      Icons.shuffle_rounded,
      size: 30,
    ),
    Icon(
      Icons.edit,
      size: 30,
    ),
    Icon(
      Icons.history_rounded,
      size: 30,
    )
  ];
  @override
  State<DoublesGenerator> createState() => _DoublesGeneratorState();
}

class _DoublesGeneratorState extends State<DoublesGenerator> {
  var index = 0;
  Future<Map<String,List>> soFar() async {
    var serviceProvider = SoFar(
      groupid: widget.tid,
      password: widget.pwd,
      resource: 'randomize',
    );
    var result = await serviceProvider.get();
    result.remove("result");
    Map<String,List> finres;
    finres = Map<String,List>.from(result);
    return finres;
  }
  Future<Map<String,List>> remove(String player) async{
    Map<String,List> finResult={};
    var serviceProvider = Remove(groupid: widget.tid,password: widget.pwd, player: player, resource: 'remove');
    Map result = await serviceProvider.patch();
    if(result["result"]!="OK"){
      if(!mounted) {
        return finResult;
      }
      snackbar(context, "Unforeseen error occurred!!");
    }
    finResult = await soFar();
    return finResult;
  }
  Future<Map<String,List>> adder(String player) async{
    Map<String,List> finResult={};
    var serviceProvider = Add(groupid: widget.tid,password: widget.pwd, player: player, resource: 'add');
    Map result = await serviceProvider.patch();
    if(result["result"]!="OK"){
      if(!mounted) {
        return finResult;
      }
      snackbar(context, "Unforeseen error occurred!!");
    }
    finResult = await soFar();
    return finResult;
  }
  Future<List<Widget>> clear() async {
    var serviceProvider = Clear(
      groupid: widget.tid,
      password: widget.pwd,
      resource: 'clearAllTeams',
    );
    var result = await serviceProvider.patch();
    if (result["result"] == "OK") {
      if (!mounted) {
        return randomizer(activate: false);
      }
      snackbar(context, "Previous Matchups cleared successfully!");
    } else {
      if (!mounted) {
        return randomizer(activate: false);
      }
      snackbar(context, "Error!!");
    }
    return randomizer(activate: false);
  }

  bool _deleted = false;
  Future<void> delete() async {
    setState(() {
      _deleted = true;
    });
    var serviceProvider = Delete(
      groupid: widget.tid,
      password: widget.pwd,
      resource: 'remove',
    );
    var result = await serviceProvider.delete();
    if (result["result"] == "OK") {
      if (!mounted) {
        return;
      }
      snackbar(context, "Group Deleted! We are sad to see you go \u{1f622}");
      Navigator.pushReplacementNamed(context, RouteManager.loginRegister);
    } else {
      if (!mounted) {
        return;
      }
      snackbar(context, "Operation failed due to unforeseen error!");
    }
  }

  Future<List<Widget>> randomizer({required bool activate}) async {
    List<Widget> tbr = <Widget>[];
    if (!activate) {
      tbr = [
        Text(
          "No MatchUps in this session So far!",
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
              textStyle:
                  const TextStyle(fontSize: 30, color: Color(0xff25d050))),
        )
      ];
    } else {
      var serviceProvider = Randomize(
        groupid: widget.tid,
        password: widget.pwd,
        resource: 'randomize',
      );
      Map result = await serviceProvider.patch();
      if (result["result"] == "OK") {
        List matchUpList = result["matchUps"];
        int i = 0;
        for (; i < matchUpList.length - 1; i += 2) {
          tbr.add(Text(
            "${matchUpList[i][0]},${matchUpList[i][1]} vs ${matchUpList[i + 1][0]},${matchUpList[i + 1][1]}",
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
                textStyle:
                    const TextStyle(fontSize: 30, color: Color(0xff25d050))),
          ));
        }
        if (i < matchUpList.length) {
          tbr.add(Text(
            "${matchUpList[i][0]},${matchUpList[i][1]}",
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
                textStyle:
                    const TextStyle(fontSize: 30, color: Color(0xff25d050))),
          ));
        }
      } else if (result["result"] == "Empty") {
        tbr.add(Text(
          "All Combinations Exhausted!",
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
              textStyle:
                  const TextStyle(fontSize: 20, color: Color(0xff25d050))),
        ));
      }
    }
    return tbr;
  }

  List<Widget> title = [
    Text(
      "Randomizer",
      textAlign: TextAlign.center,
      style: GoogleFonts.caveat(
          textStyle: const TextStyle(fontSize: 40, color: Color(0xff25d050))),
    ),
    Text(
      "Edit",
      textAlign: TextAlign.center,
      style: GoogleFonts.caveat(
          textStyle: const TextStyle(fontSize: 40, color: Color(0xff25d050))),
    ),
    Text(
      "History",
      textAlign: TextAlign.center,
      style: GoogleFonts.caveat(
          textStyle: const TextStyle(fontSize: 40, color: Color(0xff25d050))),
    ),
  ];

  late List<Widget> functionalities = [
    randomize_widget.Randomize(randomizer: randomizer, clear: clear),
    Edit(soFar: soFar, remove: remove, adder: adder,),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: title[index],
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) => [
                MenuItems(
                    text: " Logout",
                    icon: Icons.logout_rounded,
                    onTap: () => WidgetsBinding.instance.addPostFrameCallback(
                        (_) => Navigator.pushReplacementNamed(
                            context, RouteManager.loginRegister))).item(),
                MenuItems(
                    text: " Delete Account",
                    icon: Icons.delete_forever_outlined,
                    onTap: () => WidgetsBinding.instance
                        .addPostFrameCallback((_) => delete())).item()
              ],
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Color(0xff25d050),
              ),
              color: Theme.of(context).hoverColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(30, 50),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
          ]),
      bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context).hoverColor,
          backgroundColor: Colors.transparent,
          items: widget.items,
          index: index,
          height: 60,
          animationCurve: Curves.easeInOut,
          onTap: (index) => setState(() {
                this.index = index;
              })),
      body: (!_deleted)
          ? functionalities[index]
          : const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ),
            ),
    );
  }
}
