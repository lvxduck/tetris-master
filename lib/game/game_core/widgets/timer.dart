import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = AutoDisposeStateNotifierProvider<TimeController, int>(
  (ref) => TimeController(),
);

class TimeController extends StateNotifier<int> {
  TimeController() : super(0) {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      state += 100;
    });
  }

  Timer? timer;

  int getTime() {
    return state;
  }

  void stopTimer() {
    timer?.cancel();
  }
}

class TimerWidget extends ConsumerWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final time = ref.watch(timeProvider);
    return Text(
      Duration(milliseconds: time).toString().substring(0, 9),
      style: const TextStyle(
        fontSize: 24,
      ),
    );
  }
}
