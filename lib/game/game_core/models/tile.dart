import 'package:flutter/material.dart';

class Tile {
  Tile(this.x, this.y);

  int x;
  int y;
  Color color = Colors.red;

  @override
  String toString() {
    return '$x, $y, $color';
  }
}
