import 'package:flutter/material.dart';
import 'package:tetris_master/game/board.dart';

import 'group_button_controls.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  final gameSize = const Size(10, 20);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: 80,
                      height: 400,
                      color: Colors.green,
                    ),
                  ),
                  const Board(),
                  Expanded(
                    child: Container(
                      width: 80,
                      height: 400,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            GroupButtonControls(),
          ],
        ),
      ),
    );
  }
}
