import 'package:doubles_generator_frontend/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      ),
      initialRoute: RouteManager.intro,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
