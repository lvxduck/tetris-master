import 'package:flutter/material.dart';
import 'package:tetris_master/game/models/block.dart';
import 'package:tetris_master/game/pages/game/widgets/tile_widget.dart';

class BlockWidget extends StatelessWidget {
  const BlockWidget({
    Key? key,
    required this.block,
    required this.tileSize,
  }) : super(key: key);
  final Block block;
  final double tileSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileSize * 4,
      height: tileSize * 3,
      child: Stack(
        children: block.currentTiles.map((e) {
          return Positioned(
            top: e.y * tileSize,
            left: e.x * tileSize,
            child: TileWidget(
              color: Colors.red,
              size: tileSize,
            ),
          );
        }).toList(),
      ),
    );
  }
}
