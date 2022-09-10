import 'package:doubles_generator_frontend/custom_widgets/utilities/history_retrieve.dart';
import 'package:doubles_generator_frontend/custom_widgets/utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class History extends StatefulWidget {
  final Future<Map<String,List>> Function() soFar;
  const History({Key? key, required this.soFar}) : super(key: key);
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<Map<String,List>> historyData;
  @override
  void initState(){
    super.initState();
    historyData=widget.soFar();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: historyData,
      builder: (context,snapshot){
        if (snapshot.hasError) {
          snackbar(context, "Unforeseen error Occurred! Please Try Again!");
          setState(() {
            historyData = widget.soFar();
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
          var data = snapshot.data! as Map;
          List<String> historyDisplay=historyRetriever(Map<String,List>.from(data));
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 60
            ),
            child: ListView.separated(
              itemCount: historyDisplay.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    historyDisplay[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                        textStyle:
                        const TextStyle(fontSize: 30, color: Color(0xff25d050))),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 40,
                  child: Divider(),
                );
              },
            ),
          );
        }
        return Container();
      });
      }
  }
