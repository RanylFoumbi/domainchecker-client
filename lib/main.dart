import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/about.dart';
import 'components/bigContainer.dart';
import 'components/home.dart';

void main() {
  /*To block Screen rotation for the whole app*/
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(new Main());
  });
}

class Main extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domain Checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BigContainer(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/about': (BuildContext context) => AboutPage(),
      },
    );
  }
}
