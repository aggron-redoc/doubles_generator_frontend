import 'package:doubles_generator_frontend/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doubles Generator',
      theme: ThemeData.dark().copyWith(
        iconTheme: const IconThemeData(
          color: Color(0xff25d050),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white12),
            foregroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff25d050)),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Theme.of(context).hintColor,
            behavior: SnackBarBehavior.floating,
            contentTextStyle: GoogleFonts.oswald(
              textStyle: const TextStyle(
                color: Color(0xff25d050),
              ),
            ),
            elevation: 5.0),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xff25d050),
        ),
      ),
      initialRoute: RouteManager.intro,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
