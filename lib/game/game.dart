import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetris_master/game/widgets/tile_widget.dart';

import 'models/block.dart';
import 'models/tile.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final List<List<int>> pieces = [];
  late List<List<Tile?>> map;
  final gameSize = const Size(10, 20);
  final duration = const Duration(milliseconds: 1000);
  final int maxBlockHeight = 3;

  bool isMoving = false;

  late AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  Timer? _debounce;

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
    // if (isMoving) return;
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
      if (tile.y + currentBlock!.y + 1 > 0 &&
          tile.y + currentBlock!.y + 1 < gameSize.height &&
          map[tile.x + currentBlock!.x][tile.y + currentBlock!.y + 1] != null) {
        return false;
      }
    }
    return true;
  }

  int numberOfTileToRotate() {
    if (currentBlock is LBlock) {
      if (currentBlock!.orientationIndex == 0) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x <= 0) {
            return 1;
          }
        }
      }
      if (currentBlock!.orientationIndex == 2) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x >= gameSize.width - 1) {
            return -1;
          }
        }
      }
    }
    if (currentBlock is IBlock) {
      if (currentBlock!.orientationIndex == 0) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == 0) {
            return 1;
          }
        }
      }
      if (currentBlock!.orientationIndex == 2) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == 0) {
            return 2;
          }
          if (tile.x + currentBlock!.x == 1) {
            return 1;
          }
        }
      }
      if (currentBlock!.orientationIndex == 0) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == gameSize.width - 1) {
            return -2;
          }
        }
      }
      if (currentBlock!.orientationIndex == 2) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == gameSize.width - 1) {
            return -1;
          }
        }
      }
    }
    if (currentBlock is TBlock) {
      if (currentBlock!.orientationIndex == 3) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == 0) {
            return 1;
          }
        }
      }
      if (currentBlock!.orientationIndex == 1) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == gameSize.width - 1) {
            return -1;
          }
        }
      }
    }
    if (currentBlock is SBlock || currentBlock is ZBlock) {
      if (currentBlock!.orientationIndex == 1) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == 0) {
            return 1;
          }
        }
      }
      if (currentBlock!.orientationIndex == 3) {
        for (final tile in currentBlock!.currentTiles) {
          if (tile.x + currentBlock!.x == gameSize.width - 1) {
            return -1;
          }
        }
      }
    }
    return 0;
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
    // if (isMoving) return;
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
        final numberOfTile = numberOfTileToRotate();
        if (numberOfTile > 0) {
          currentBlock?.move(BlockMovement.right, numberOfTile);
        }
        if (numberOfTile < 0) {
          currentBlock?.move(BlockMovement.left, -numberOfTile);
        }
        currentBlock?.move(BlockMovement.rotateClockWise);
      }
      setState(() {});
    }
    // if (event is RawKeyUpEvent) {
    //   if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
    //     if (currentBlock!.x < gameSize.width - 1) {
    //       print(currentBlock!.x);
    //       currentBlock?.move(BlockMovement.right);
    //     }
    //   }
    // }
    // if (event is RawKeyUpEvent) {
    //   if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
    //     print('right');
    //   }
    //   if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
    //     print('left');
    //   }
    //   if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
    //     print('down');
    //   }
    //   if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
    //     print('up');
    //   }
    //   if (event.logicalKey == LogicalKeyboardKey.space) {
    //     print('space');
    //   }
    //   if (event.logicalKey == LogicalKeyboardKey.keyC) {
    //     print('keyC');
    //   }
    // }
  }

  void endGame() {
    print('END GAME');
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
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: handleKeyEvent,
      child: Scaffold(
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: ColoredBox(
                  color: Colors.white10,
                  child: AspectRatio(
                    aspectRatio: 10 / 23,
                    child: LayoutBuilder(builder: (context, box) {
                      final tileSize = box.maxWidth / gameSize.width;
                      List<Widget> tiles = [];
                      for (int x = 0; x < gameSize.width; x++) {
                        for (int y = 0; y < gameSize.height; y++) {
                          tiles.add(
                            Positioned(
                              top: (y + maxBlockHeight) * tileSize,
                              left: x * tileSize,
                              child: TileWidget(
                                color: map[x][y]?.color ?? Colors.grey[900]!,
                                size: tileSize,
                              ),
                            ),
                          );
                        }
                      }
                      if (currentBlock != null) {
                        isMoving = true;
                        for (final tile in currentBlock!.currentTiles) {
                          tiles.add(
                            // AnimatedBuilder(
                            //   key: Key('key :${tile.x} ${tile.y}'),
                            //   animation: controller,
                            //   builder: (_, __) {
                            //     return Positioned(
                            //       top: (tile.y +
                            //               currentBlock!.y +
                            //               maxBlockHeight) *
                            //           tileSize,
                            //       left: (tile.x + currentBlock!.x) * tileSize,
                            //       child: TileWidget(
                            //         color: tile.color,
                            //         size: tileSize,
                            //       ),
                            //     );
                            //   },
                            // ),
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
                              onEnd: () {
                                isMoving = false;
                                print('end');
                              },
                            ),
                          );
                        }
                      }
                      return Stack(
                        children: tiles,
                      );
                    }),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 400,
                color: Colors.green,
              ),
            ],
          ),
        ),
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
