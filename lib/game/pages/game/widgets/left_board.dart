import 'package:flutter/material.dart';
import 'package:tetris_master/game/models/block.dart';
import 'package:tetris_master/game/pages/game/widgets/timer.dart';

import 'block_widget.dart';

class LeftBoard extends StatefulWidget {
  const LeftBoard({
    Key? key,
    required this.numberOfLine,
    required this.gameSize,
    required this.extraGameHeight,
    this.holdBlock,
  }) : super(key: key);
  final Size gameSize;
  final int numberOfLine;
  final int extraGameHeight;
  final Block? holdBlock;

  @override
  LeftBoardState createState() => LeftBoardState();
}

class LeftBoardState extends State<LeftBoard> {
  final timerKey = GlobalKey<TimerWidgetState>();

  void stopTimer() {
    timerKey.currentState!.stopTimer();
  }

  int getTime() {
    return timerKey.currentState!.getTime();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      final boardTileSize =
          box.maxHeight / (widget.gameSize.height + widget.extraGameHeight);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: boardTileSize * 3),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            constraints: BoxConstraints(maxWidth: boardTileSize * 4),
            alignment: Alignment.centerLeft,
            child: const Text(
              'HOLD',
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
                return widget.holdBlock == null
                    ? SizedBox(
                        width: tileSize * 4,
                        height: tileSize * 3,
                      )
                    : BlockWidget(block: widget.holdBlock!, tileSize: tileSize);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(top: boardTileSize * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('LINES'),
                Text(
                  widget.numberOfLine.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8),
                const Text('TIME'),
                TimerWidget(key: timerKey),
              ],
            ),
          ),
        ],
      );
    });
  }
}
