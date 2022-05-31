import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetris_master/game/widgets/empty_tile_widget.dart';

import 'models/block.dart';
import 'models/tile.dart';
import 'widgets/tile_widget.dart';

class Board extends StatefulWidget {
  const Board({
    Key? key,
    this.gameSize = const Size(10, 20),
  }) : super(key: key);
  final Size gameSize;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final FocusNode _focusNode = FocusNode();
  late Size gameSize = widget.gameSize;

  final List<List<int>> pieces = [];
  late List<List<Tile?>> map;
  final duration = const Duration(milliseconds: 1000);
  final int maxBlockHeight = 3;

  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;
  Block? currentBlock;
  Timer? timer;

  Block getRandomBlock() {
    int blockType = Random().nextInt(7);
    int orientationIndex = Random().nextInt(4);

    switch (blockType) {
      case 0:
        return IBlock(orientationIndex);
      case 1:
        return JBlock(orientationIndex);
      case 2:
        return LBlock(orientationIndex);
      case 3:
        return OBlock(orientationIndex);
      case 4:
        return TBlock(orientationIndex);
      case 5:
        return SBlock(orientationIndex);
      case 6:
        return ZBlock(orientationIndex);
      default:
        throw Exception('Block not found');
    }
  }

  void startGame() {
    setState(() {
      isPlaying = true;
      isGameOver = false;
      score = 0;
      currentBlock = getRandomBlock();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      currentBlock?.move(BlockMovement.down);
      timer = Timer.periodic(duration, update);
    });
  }

  void update(_) async {
    if (isAbleToMoveDown()) {
      currentBlock?.move(BlockMovement.down);
    } else {
      // merge block to map and random new block
      for (final tile in currentBlock!.currentTiles) {
        if (tile.y + currentBlock!.y >= 0) {
          map[tile.x + currentBlock!.x][tile.y + currentBlock!.y] = tile;
        } else {
          endGame();
          return;
        }
      }
      setState(() {
        currentBlock = getRandomBlock();
      });
      return;
    }
    // check collision with bottom board;
    if (currentBlock!.y + currentBlock!.height == gameSize.height) {
      for (final tile in currentBlock!.currentTiles) {
        map[tile.x + currentBlock!.x][tile.y + currentBlock!.y] = tile;
      }
      currentBlock = getRandomBlock();
    }
    setState(() {});
  }

  bool isAbleToMoveDown() {
    for (final tile in currentBlock!.currentTiles) {
      if (tile.y + currentBlock!.y + 1 >= gameSize.height) {
        return false;
      }
      if (tile.x + currentBlock!.x >= 0 &&
          tile.y + currentBlock!.y + 1 > 0 &&
          tile.y + currentBlock!.y + 1 < gameSize.height &&
          map[tile.x + currentBlock!.x][tile.y + currentBlock!.y + 1] != null) {
        return false;
      }
    }
    return true;
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

  bool isAbleToMoveRight() {
    for (final tile in currentBlock!.currentTiles) {
      if (tile.x + currentBlock!.x + 1 >= gameSize.width) {
        return false;
      }
      if (tile.x + currentBlock!.x + 1 < gameSize.width &&
          tile.y + currentBlock!.y >= 0 &&
          map[tile.x + currentBlock!.x + 1][tile.y + currentBlock!.y] != null) {
        return false;
      }
    }
    return true;
  }

  bool isAbleToMoveLeft() {
    for (final tile in currentBlock!.currentTiles) {
      if (tile.x + currentBlock!.x - 1 < 0) {
        return false;
      }
      if (tile.x + currentBlock!.x - 1 >= 0 &&
          tile.y + currentBlock!.y >= 0 &&
          map[tile.x + currentBlock!.x - 1][tile.y + currentBlock!.y] != null) {
        return false;
      }
    }
    return true;
  }

  void handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
        if (isAbleToMoveRight()) {
          currentBlock?.move(BlockMovement.right);
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
        if (isAbleToMoveLeft()) {
          currentBlock?.move(BlockMovement.left);
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
        if (isAbleToMoveDown()) {
          currentBlock?.move(BlockMovement.down);
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
        while (isAbleToMoveDown()) {
          currentBlock?.move(BlockMovement.down);
          setState(() {});
        }
      }
      setState(() {});
    }
  }

  void endGame() {
    timer?.cancel();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
      child: AspectRatio(
        aspectRatio: gameSize.width / (gameSize.height + maxBlockHeight),
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
                  top: (tile.y + currentBlock!.y + maxBlockHeight) * tileSize,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    _focusNode.dispose();
  }
}
