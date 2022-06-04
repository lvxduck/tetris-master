import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  int time = 0;
  Timer? timer;

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        time += 100;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      Duration(milliseconds: time).toString().substring(0, 9),
    );
  }
}
