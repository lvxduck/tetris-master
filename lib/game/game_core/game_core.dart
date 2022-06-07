import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/game_core/controller/game_core_controller.dart';

import 'widgets/empty_tile_widget.dart';
import 'widgets/left_board.dart';
import 'widgets/right_board.dart';
import 'widgets/tile_widget.dart';

class GameCore extends ConsumerWidget {
  const GameCore({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final controller = ref.watch(gameCoreProvider);
    FocusScope.of(context).requestFocus(controller.focusNode);
    final gameSize = controller.config.gameSize;
    return RawKeyboardListener(
      focusNode: controller.focusNode,
      onKey: controller.handleKeyEvent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: LeftBoard(
                gameSize: gameSize,
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
                      top: (y + controller.config.extraHeight) * tileSize,
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
                              controller.config.extraHeight) *
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
}
