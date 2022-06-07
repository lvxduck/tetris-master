import 'package:flutter/material.dart';
import 'package:tetris_master/game/game_core/models/game_config.dart';
import 'package:tetris_master/game/models/block.dart';

import 'block_widget.dart';

class RightBoard extends StatelessWidget {
  const RightBoard({
    Key? key,
    required this.gameSize,
    required this.extraGameHeight,
    required this.blocks,
  }) : super(key: key);

  final GameSize gameSize;
  final int extraGameHeight;
  final List<Block> blocks;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      final boardTileSize = box.maxHeight / (gameSize.height + extraGameHeight);
      return Column(
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: boardTileSize * 3),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            constraints: BoxConstraints(maxWidth: boardTileSize * 4),
            alignment: Alignment.centerLeft,
            child: const Text(
              'NEXT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white),
            ),
            constraints: BoxConstraints(maxWidth: boardTileSize * 4),
            child: LayoutBuilder(
              builder: (context, box) {
                final tileSize = box.maxWidth / 4;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...blocks
                        .map((e) => BlockWidget(block: e, tileSize: tileSize))
                        .toList(),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
