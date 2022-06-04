import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_master/game/models/tile.dart';

enum BlockMovement {
  up,
  down,
  left,
  right,
  rotateClockWise,
  rotateCounterClockWise,
}

class Block {
  List<List<Tile>> orientations = <List<Tile>>[];
  int x;
  late int y;
  int orientationIndex;

  Block({
    required this.orientations,
    required Color color,
    required this.orientationIndex,
    this.x = 3,
  }) {
    y = -height;
    for (var orientation in orientations) {
      for (var tile in orientation) {
        tile.color = color;
      }
    }
  }

  List<Tile> get currentTiles {
    return orientations[orientationIndex];
  }

  get width {
    int maxX = 0;
    for (var tile in currentTiles) {
      if (tile.x > maxX) maxX = tile.x;
    }
    return maxX + 1;
  }

  get height {
    int maxY = 0;
    for (var tile in currentTiles) {
      if (tile.y > maxY) maxY = tile.y;
    }
    return maxY + 1;
  }

  static Block getRandomBlock() {
    int blockType = Random().nextInt(7);
    switch (blockType) {
      case 0:
        return IBlock(1);
      case 1:
        return JBlock(1);
      case 2:
        return LBlock(1);
      case 3:
        return OBlock(1);
      case 4:
        return TBlock(1);
      case 5:
        return SBlock(1);
      case 6:
        return ZBlock(1);
      default:
        throw Exception('Block not found');
    }
  }

  void move(BlockMovement blockMovement, [int distance = 1]) {
    switch (blockMovement) {
      case BlockMovement.up:
        y -= distance;
        break;
      case BlockMovement.down:
        y += distance;
        break;
      case BlockMovement.left:
        x -= distance;
        break;
      case BlockMovement.right:
        x += distance;
        break;
      case BlockMovement.rotateClockWise:
        orientationIndex = ++orientationIndex % 4;
        break;
      case BlockMovement.rotateCounterClockWise:
        orientationIndex = (orientationIndex + 3) % 4;
        break;
    }
  }
}

class IBlock extends Block {
  IBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(1, 0), Tile(1, 1), Tile(1, 2), Tile(1, 3)],
            [Tile(0, 1), Tile(1, 1), Tile(2, 1), Tile(3, 1)],
            [Tile(2, 0), Tile(2, 1), Tile(2, 2), Tile(2, 3)],
            [Tile(0, 2), Tile(1, 2), Tile(2, 2), Tile(3, 2)],
          ],
          color: Colors.red,
          orientationIndex: orientationIndex,
        );
}

class JBlock extends Block {
  JBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(1, 0), Tile(1, 1), Tile(1, 2), Tile(0, 2)],
            [Tile(0, 0), Tile(0, 1), Tile(1, 1), Tile(2, 1)],
            [Tile(1, 0), Tile(2, 0), Tile(1, 1), Tile(1, 2)],
            [Tile(0, 1), Tile(1, 1), Tile(2, 1), Tile(2, 2)],
          ],
          color: Colors.yellow,
          orientationIndex: orientationIndex,
        );
}

class LBlock extends Block {
  LBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(1, 0), Tile(1, 1), Tile(1, 2), Tile(2, 2)],
            [Tile(0, 2), Tile(0, 1), Tile(1, 1), Tile(2, 1)],
            [Tile(0, 0), Tile(1, 0), Tile(1, 1), Tile(1, 2)],
            [Tile(0, 1), Tile(1, 1), Tile(2, 1), Tile(2, 0)],
          ],
          color: Colors.green,
          orientationIndex: orientationIndex,
        );
}

class OBlock extends Block {
  OBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(0, 0), Tile(1, 0), Tile(0, 1), Tile(1, 1)],
            [Tile(0, 0), Tile(1, 0), Tile(0, 1), Tile(1, 1)],
            [Tile(0, 0), Tile(1, 0), Tile(0, 1), Tile(1, 1)],
            [Tile(0, 0), Tile(1, 0), Tile(0, 1), Tile(1, 1)],
          ],
          color: Colors.blue,
          orientationIndex: orientationIndex,
        );
}

class TBlock extends Block {
  TBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(0, 1), Tile(1, 1), Tile(2, 1), Tile(1, 2)],
            [Tile(0, 1), Tile(1, 0), Tile(1, 1), Tile(1, 2)],
            [Tile(1, 0), Tile(0, 1), Tile(1, 1), Tile(2, 1)],
            [Tile(1, 0), Tile(1, 1), Tile(1, 2), Tile(2, 1)],
          ],
          color: Colors.purple,
          orientationIndex: orientationIndex,
        );
}

class SBlock extends Block {
  SBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(1, 0), Tile(2, 0), Tile(0, 1), Tile(1, 1)],
            [Tile(1, 0), Tile(1, 1), Tile(2, 1), Tile(2, 2)],
            [Tile(0, 2), Tile(1, 2), Tile(1, 1), Tile(2, 1)],
            [Tile(0, 0), Tile(0, 1), Tile(1, 1), Tile(1, 2)],
          ],
          color: Colors.orange,
          orientationIndex: orientationIndex,
        );
}

class ZBlock extends Block {
  ZBlock(int orientationIndex)
      : super(
          orientations: [
            [Tile(0, 0), Tile(1, 0), Tile(1, 1), Tile(2, 1)],
            [Tile(2, 0), Tile(2, 1), Tile(1, 1), Tile(1, 2)],
            [Tile(0, 1), Tile(1, 1), Tile(1, 2), Tile(2, 2)],
            [Tile(1, 0), Tile(1, 1), Tile(0, 1), Tile(0, 2)],
          ],
          color: Colors.cyan,
          orientationIndex: orientationIndex,
        );
}
