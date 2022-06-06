import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/game_core/widgets/left_board.dart';
import 'package:tetris_master/game/models/block.dart';
import 'package:tetris_master/game/models/tile.dart';

import 'base_game_controller.dart';

final gameCoreProvider = AutoDisposeChangeNotifierProvider<GameCoreController>(
  (ref) => GameCoreController(),
);

enum GameState { init, playing, gameOver }

class GameCoreController extends ChangeNotifier with BaseGameController {
  final leftBoardKey = GlobalKey<LeftBoardState>();

  //game setting
  Size gameSize = const Size(10, 20);
  final int maxBlockHeight = 3;

  //game state
  final List<List<int>> pieces = [];
  List<List<Tile?>> map = [];
  int numberOfLine = 0;
  GameState gameState = GameState.init;
  int score = 0;
  Block? currentBlock;
  Block? holdBlock;
  List<Block> nextRandomBlocks = [];

  void init({required Size gameSize}) {
    start();
    this.gameSize = gameSize;
  }

  @override
  void start() {
    super.start();
    for (int i = 1; i <= 5; i++) {
      nextRandomBlocks.add(Block.getRandomBlock());
    }
    map = List.generate(
      gameSize.width.toInt(),
      (index) => List.generate(
        gameSize.height.toInt(),
        (index) => null,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startGame();
    });
  }

  void startGame() {
    gameState = GameState.playing;
    score = 0;
    randomNextBlock();
    Future.delayed(const Duration(milliseconds: 100), () {
      currentBlock?.move(BlockMovement.down);
      // timer = Timer.periodic(duration, update);
    });
    notifyListeners();
  }

  @override
  void update(Timer timer) async {
    currentBlock?.move(BlockMovement.down, 1);
    if (!isValidBlock()) {
      currentBlock?.move(BlockMovement.up, 1);
      mergeBlock();
    }
    handleMapChange();
    notifyListeners();
  }

  @override
  void endGame() {
    super.endGame();
    leftBoardKey.currentState!.stopTimer();
    // widget.onEndGame();
    notifyListeners();
  }

  void handleMapChange() {
    var numberOfLine = 0;
    for (int y = 0; y < gameSize.height; y++) {
      bool shouldDelete = true;
      for (int x = 0; x < gameSize.width; x++) {
        if (map[x][y] == null) {
          shouldDelete = false;
        }
      }
      if (shouldDelete) {
        numberOfLine += 1;
        for (int x = 0; x < gameSize.width; x++) {
          map[x][y] = null;
        }
        translateMapDown(y);
      }
    }
    this.numberOfLine += numberOfLine;
    notifyListeners();
    // widget.onNumberOfLineChange(this.numberOfLine);
  }

  void translateMapDown(int startY) {
    for (int y = startY; y > 0; y--) {
      for (int x = 0; x < gameSize.width; x++) {
        map[x][y] = map[x][y - 1];
      }
    }
  }

  void randomNextBlock() {
    currentBlock = nextRandomBlocks.first;
    nextRandomBlocks.removeAt(0);
    nextRandomBlocks.add(Block.getRandomBlock());
  }

  void mergeBlock() {
    for (final tile in currentBlock!.currentTiles) {
      if (tile.y + currentBlock!.y >= 0) {
        map[tile.x + currentBlock!.x][tile.y + currentBlock!.y] = tile;
      } else {
        endGame();
        return;
      }
    }
    randomNextBlock();
    handleMapChange();
  }

  bool isValidBlock() {
    for (final tile in currentBlock!.currentTiles) {
      if (tile.x + currentBlock!.x < 0 ||
          tile.x + currentBlock!.x >= gameSize.width) {
        return false;
      }
      if (tile.y + currentBlock!.y >= gameSize.height) {
        return false;
      }
      if (tile.y + currentBlock!.y >= 0 &&
          map[tile.x + currentBlock!.x][tile.y + currentBlock!.y] != null) {
        return false;
      }
    }
    return true;
  }

  void handleKeyEvent(RawKeyEvent event) {
    if (timer != null && !timer!.isActive) return;
    if (event is RawKeyDownEvent) {
      if (event.isKeyPressed(LogicalKeyboardKey.keyC)) {
        final block = holdBlock;
        holdBlock = currentBlock;
        currentBlock = block;

        if (currentBlock == null) {
          randomNextBlock();
        } else {
          currentBlock!.x = holdBlock!.x;
          currentBlock!.y = holdBlock!.y;
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
        currentBlock?.move(BlockMovement.right, 1);
        if (!isValidBlock()) {
          currentBlock?.move(BlockMovement.left, 1);
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        currentBlock?.move(BlockMovement.left, 1);
        if (!isValidBlock()) {
          currentBlock?.move(BlockMovement.right, 1);
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
        currentBlock?.move(BlockMovement.down, 1);
        if (!isValidBlock()) {
          currentBlock?.move(BlockMovement.up, 1);
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
        for (int distance in [0, -1, 1, -2, 2]) {
          currentBlock?.move(BlockMovement.right, distance);
          currentBlock?.move(BlockMovement.rotateClockWise);
          if (!isValidBlock()) {
            currentBlock?.move(BlockMovement.rotateCounterClockWise);
            currentBlock?.move(BlockMovement.left, distance);
          } else {
            break;
          }
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.space)) {
        do {
          currentBlock?.move(BlockMovement.down, 1);
        } while (isValidBlock());
        currentBlock?.move(BlockMovement.up, 1);
        mergeBlock();
      }
      notifyListeners();
    }
  }
}
