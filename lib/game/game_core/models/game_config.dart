class GameSize {
  GameSize(this.width, this.height);

  final int width;
  final int height;
}

class GameConfig {
  GameConfig({
    required this.gameSize,
    this.extraHeight = 3,
    required this.speed,
    required this.accelerator,
  });

  final GameSize gameSize;
  final int extraHeight;
  final double speed;
  final double accelerator;
}
