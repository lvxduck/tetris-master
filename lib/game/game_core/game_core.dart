import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/game_core/controller/game_core_controller.dart';

import 'widgets/empty_tile_widget.dart';
import 'widgets/left_board.dart';
import 'widgets/right_board.dart';
import 'widgets/tile_widget.dart';

class GameCore extends ConsumerStatefulWidget {
  const GameCore({
    Key? key,
    this.gameSize = const Size(10, 20),
    required this.onEndGame,
    required this.onNumberOfLineChange,
  }) : super(key: key);
  final Size gameSize;
  final VoidCallback onEndGame;
  final void Function(int numberOfLines) onNumberOfLineChange;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends ConsumerState<GameCore> {
  final FocusNode focusNode = FocusNode();
  late GameCoreController controller;
  late Size gameSize = widget.gameSize;

  @override
  void initState() {
    ref.read(gameCoreProvider).init(gameSize: gameSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(gameCoreProvider);
    FocusScope.of(context).requestFocus(focusNode);
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: controller.handleKeyEvent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: LeftBoard(
                key: controller.leftBoardKey,
                gameSize: widget.gameSize,
                numberOfLine: controller.numberOfLine,
                extraGameHeight: 3,
                holdBlock: controller.holdBlock,
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
                      top: (y + controller.maxBlockHeight) * tileSize,
                      left: x * tileSize,
                      child: controller.map[x][y] == null
                          ? EmptyTileWidget(
                              size: tileSize,
                            )
                          : TileWidget(
                              color: controller.map[x][y]!.color,
                              size: tileSize,
                            ),
                    ),
                  );
                }
              }
              if (controller.currentBlock != null) {
                for (final tile in controller.currentBlock!.currentTiles) {
                  tiles.add(
                    AnimatedPositioned(
                      key: Key('key :${tile.x} ${tile.y}'),
                      top: (tile.y +
                              controller.currentBlock!.y +
                              controller.maxBlockHeight) *
                          tileSize,
                      left: (tile.x + controller.currentBlock!.x) * tileSize,
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
                blocks: controller.nextRandomBlocks,
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
    controller.timer?.cancel();
    focusNode.dispose();
  }
}
