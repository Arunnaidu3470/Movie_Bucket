import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Movie Bucket',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: RootPage(),
    );
  }
}
