import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_master/game/models/block.dart';
import 'package:tetris_master/game/pages/game/widgets/board.dart';

import '../../group_button_controls.dart';
import 'widgets/block_widget.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  final gameSize = const Size(10, 20);
  int numberOfLine = 0;
  int time = 0;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        time += 100;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('LINES'),
                          Text(numberOfLine.toString()),
                          const SizedBox(height: 8),
                          const Text('TIME'),
                          Text(Duration(milliseconds: time)
                              .toString()
                              .substring(0, 9)),
                        ],
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: gameSize.width / (gameSize.height + 3),
                  child: Board(
                    gameSize: gameSize,
                    onRemoveLine: (quantity) {
                      setState(() {
                        numberOfLine += quantity;
                      });
                    },
                    onEndGame: () {
                      timer?.cancel();
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 80,
                    height: 400,
                    child: BlockWidget(
                      block: TBlock(1),
                      tileSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const GroupButtonControls(),
        ],
      ),
    );
  }
}
