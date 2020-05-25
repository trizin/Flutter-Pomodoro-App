import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          canvasColor: Color(0xFF111111),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.white,
                  fontFamily: "sans-serif",
                  fontSize: 85,
                  fontWeight: FontWeight.w300),
              bodyText2: TextStyle(
                  color: Colors.white,
                  fontFamily: "sans-serif",
                  fontSize: 85,
                  fontWeight: FontWeight.w700))),
    );
  }
}
