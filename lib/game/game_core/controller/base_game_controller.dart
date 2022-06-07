import 'dart:async';

enum GameState { init, playing, gameOver }

abstract class BaseGameController {
  var gameState = GameState.init;
  final duration = const Duration(milliseconds: 1000);
  Timer? timer;

  void start() {
    gameState = GameState.playing;
    timer = Timer.periodic(duration, update);
  }

  void update(Timer timer);

  void endGame() {
    timer?.cancel();
    gameState = GameState.gameOver;
  }
}
