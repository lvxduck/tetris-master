abstract class GameMode {
  final String songMode;
  final dynamic personalBest;

  GameMode({required this.songMode, this.personalBest});
}

class FortyLinesMode extends GameMode {
  FortyLinesMode({required super.songMode, required String super.personalBest});
}
