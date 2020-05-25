import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PMode { Study, Break, LongBreak }

class Pomodoro {
  int count = 0;
  int step = 0;
  int breakTime = 5 * 60;
  int studyTime = 25 * 60;
  int longBreakTime = 30 * 60;
  bool running = false;
  Map colorMap = {
    PMode.Study: Colors.red,
    PMode.Break: Colors.indigo,
    PMode.LongBreak: Colors.indigoAccent
  };
  PMode mode = PMode.Study;

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    count = (prefs.getInt('counter') ?? 0);
    step = (prefs.getInt('step') ?? 0);
    mode = PMode.values[(prefs.getInt('mode') ?? 0)];
  }

  void increasePomodoro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (running) count += 1;
    await prefs.setInt('counter', count);

    // checkss
    if ((count == breakTime && mode == PMode.Break) ||
        (count == longBreakTime && mode == PMode.LongBreak)) {
      await skip();
    }
    if ((count == studyTime && mode == PMode.Study)) {
      await skip();
    }
    // check end
  }

  skip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    count = 0;
    switch (mode) {
      case PMode.Break:
        mode = PMode.Study;
        await prefs.setInt('counter', count);
        prefs.setInt('mode', PMode.values.indexOf(mode));
        prefs.setInt('step', step);
        break;
      case PMode.LongBreak:
        mode = PMode.Study;
        await prefs.setInt('counter', count);
        prefs.setInt('mode', PMode.values.indexOf(mode));
        prefs.setInt('step', step);
        break;
      case PMode.Study:
        step += 1;
        if (step % 4 == 0) {
          mode = PMode.LongBreak;
        } else {
          mode = PMode.Break;
        }
        await prefs.setInt('counter', count);
        prefs.setInt('mode', PMode.values.indexOf(mode));
        prefs.setInt('step', step);
        break;
    }
  }

  double get percentage {
    switch (mode) {
      case PMode.Break:
        return count / breakTime;
      case PMode.LongBreak:
        return count / longBreakTime;
      case PMode.Study:
        return count / studyTime;
      default:
        return 5;
    }
  }

  Color get getColor {
    return colorMap[mode];
  }

  String get readTime {
    int time;
    switch (mode) {
      case PMode.Break:
        time = breakTime;
        break;
      case PMode.LongBreak:
        time = longBreakTime;
        break;
      case PMode.Study:
        time = studyTime;
        break;
    }
    int ct = time - count;
    int seconds = (ct % 60);
    int minutes = (ct / 60).floor();
    return "${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}";
  }

  String get modeText {
    switch (mode) {
      case PMode.Break:
        return "break";
      case PMode.LongBreak:
        return "long break";
      case PMode.Study:
        return "study";
      default:
        return "";
    }
  }

  int get stepCount {
    return step;
  }

  bool get isRunning {
    return running;
  }

  void toggleRunning() {
    running = !running;
  }
}
