import 'dart:async';

abstract class BaseGameController {
  final duration = const Duration(milliseconds: 1000);
  Timer? timer;

  void start() {
    timer = Timer.periodic(duration, update);
  }

  void update(Timer timer);

  void endGame() {
    timer?.cancel();
  }
}
