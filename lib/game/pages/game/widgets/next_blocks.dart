import 'package:flutter/material.dart';

import '../../../models/block.dart';
import 'block_widget.dart';

class NextBlocks extends StatelessWidget {
  const NextBlocks({
    Key? key,
    required this.gameSize,
    required this.extraGameHeight,
  }) : super(key: key);

  final Size gameSize;
  final int extraGameHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      final boardTileSize = box.maxHeight / (gameSize.height + extraGameHeight);
      return Container(
        margin: EdgeInsets.only(top: boardTileSize * 3),
        color: Colors.green,
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: boardTileSize * 5),
        child: LayoutBuilder(
          builder: (context, box) {
            final tileSize = box.maxWidth / 5;
            return Column(
              children: [
                const Text(
                  'NEXT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BlockWidget(
                  block: TBlock(1),
                  tileSize: tileSize,
                ),
                BlockWidget(
                  block: LBlock(1),
                  tileSize: tileSize,
                ),
                BlockWidget(
                  block: IBlock(1),
                  tileSize: tileSize,
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
