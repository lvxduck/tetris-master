import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/block.dart';
import '../models/tile.dart';
import 'empty_tile_widget.dart';
import 'left_board.dart';
import 'right_board.dart';
import 'tile_widget.dart';

class Board extends StatefulWidget {
  const Board({
    Key? key,
    this.gameSize = const Size(10, 20),
    required this.onEndGame,
    required this.onNumberOfLineChange,
  }) : super(key: key);
  final Size gameSize;
  final VoidCallback onEndGame;
  final void Function(int numberOfLines) onNumberOfLineChange;

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  final leftBoardKey = GlobalKey<LeftBoardState>();
  final FocusNode _focusNode = FocusNode();
  late Size gameSize = widget.gameSize;

  final List<List<int>> pieces = [];
  late List<List<Tile?>> map;
  final duration = const Duration(milliseconds: 1000);
  final int maxBlockHeight = 3;
  int numberOfLine = 0;

  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;
  Block? currentBlock;
  Block? holdBlock;
  List<Block> nextRandomBlocks = [];
  Timer? timer;

  void update(_) async {
    currentBlock?.move(BlockMovement.down, 1);
    if (!isValidBlock()) {
      currentBlock?.move(BlockMovement.up, 1);
      mergeBlock();
    }
    handleMapChange();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: handleKeyEvent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: LeftBoard(
                key: leftBoardKey,
                gameSize: gameSize,
                numberOfLine: numberOfLine,
                extraGameHeight: 3,
                holdBlock: holdBlock,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: gameSize.width / (gameSize.height + 3),
            child: LayoutBuilder(builder: (context, box) {
              final tileSize = box.maxWidth / gameSize.width;
              List<Widget> tiles = [];
              for (int x = 0; x < gameSize.width; x++) {
                for (int y = 0; y < gameSize.height; y++) {
                  tiles.add(
                    Positioned(
                      top: (y + maxBlockHeight) * tileSize,
                      left: x * tileSize,
                      child: map[x][y] == null
                          ? EmptyTileWidget(
                              size: tileSize,
                            )
                          : TileWidget(
                              color: map[x][y]!.color,
                              size: tileSize,
                            ),
                    ),
                  );
                }
              }
              if (currentBlock != null) {
                for (final tile in currentBlock!.currentTiles) {
                  tiles.add(
                    AnimatedPositioned(
                      key: Key('key :${tile.x} ${tile.y}'),
                      top: (tile.y + currentBlock!.y + maxBlockHeight) *
                          tileSize,
                      left: (tile.x + currentBlock!.x) * tileSize,
                      duration: const Duration(milliseconds: 10),
                      child: TileWidget(
                        color: tile.color,
                        size: tileSize,
                      ),
                    ),
                  );
                }
              }
              return Stack(
                children: tiles,
              );
            }),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: RightBoard(
                blocks: nextRandomBlocks,
                gameSize: gameSize,
                extraGameHeight: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    _focusNode.dispose();
  }

  void startGame() {
    setState(() {
      isPlaying = true;
      isGameOver = false;
      score = 0;
      randomNextBlock();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      currentBlock?.move(BlockMovement.down);
      timer = Timer.periodic(duration, update);
    });
  }

  void endGame() {
    timer?.cancel();
    setState(() {});
    leftBoardKey.currentState!.stopTimer();
    widget.onEndGame();
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
    setState(() {
      this.numberOfLine += numberOfLine;
    });
    widget.onNumberOfLineChange(this.numberOfLine);
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
      if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
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
      setState(() {});
    }
  }
}
