import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/models/pomodoro.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AnimationController animationController;
  Pomodoro pomodoro = new Pomodoro();
  bool running = false;

  @override
  void initState() {
    super.initState();

    Timer timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if (!running) return;
      setState(() {
        pomodoro.increasePomodoro();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  pomodoro.readTime,
                  style: (Theme.of(context).textTheme.bodyText1),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: IconButton(
                  icon: Icon(running ? Icons.pause : Icons.play_arrow),
                  iconSize: 125,
                  color: running ? Colors.red : Colors.green,
                  onPressed: () {
                    setState(() {
                      running = !running;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
