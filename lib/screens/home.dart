import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/models/pomodoro.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  Pomodoro pomodoro = new Pomodoro();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF212121), // navigation bar color
      statusBarColor: Color(0xFF101010), // status bar color
    ));
    pomodoro.init();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Timer timer = new Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        pomodoro.increasePomodoro();
      });
    });
  }

  _onpressed() {
    setState(() {
      pomodoro.toggleRunning();
      pomodoro.isRunning ? controller.forward() : controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            pomodoro.readTime,
                            style: (Theme.of(context).textTheme.bodyText1),
                          ),
                        ),
                        Positioned(
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(5 / 100),
                            child: Text(
                              pomodoro.stepCount.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: pomodoro.getColor),
                            ),
                          ),
                          top: 0,
                          right: 0,
                        )
                      ],
                    ),
                    buildAnimatedContainer(context),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      pomodoro.modeText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: pomodoro.getColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.skip_next),
                            onPressed: () => pomodoro.skip(),
                            iconSize: 55,
                            color: Colors.grey),
                        /* IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () => null,
                            iconSize: 55,
                            color: Colors.indigo), */ //TODO Add settings page
                      ],
                    ),
                    IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: controller,
                      ),
                      iconSize: 125,
                      color: pomodoro.isRunning ? Colors.red : Colors.green,
                      onPressed: _onpressed,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildAnimatedContainer(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(left: 0),
      width:
          (MediaQuery.of(context).size.width - 100) * pomodoro.percentage + 10,
      height: 10,
      decoration: BoxDecoration(
        color: pomodoro.getColor,
        borderRadius: BorderRadius.circular(15),
      ),
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
