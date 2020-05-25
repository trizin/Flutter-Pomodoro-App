enum PMode { Study, Break, LongBreak }

class Pomodoro {
  int count = 0;
  int step = 0;
  int breakTime = 5 * 60;
  int studyTime = 25 * 60;
  int longBreakTime = 30 * 60;
  PMode mode = PMode.Study;

  void increasePomodoro() {
    count += 1;

    // checkss
    if ((count == breakTime && mode == PMode.Break) ||
        (count == longBreakTime && mode == PMode.LongBreak)) {
      mode = PMode.Study;
      count = 0;
    }
    if ((count == studyTime && mode == PMode.Study)) {
      step += 1;
      if (step % 4 == 0) {
        mode = PMode.LongBreak;
      } else {
        mode = PMode.Break;
      }
      count = 0;
    }
    // check end
  }

  String get readTime {
    int seconds = (count % 60);
    int minutes = (count / 60).floor();

    return "${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}";
  }
}
