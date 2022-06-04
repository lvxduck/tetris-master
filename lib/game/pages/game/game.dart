import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris_master/game/pages/game/widgets/board.dart';

import '../../group_button_controls.dart';

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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'http://chiase24.com/wp-content/uploads/2022/02/Tong-hop-cac-hinh-anh-background-dep-nhat-21.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black45,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Board(
                  gameSize: gameSize,
                  onEndGame: () {
                    timer?.cancel();
                  },
                ),
              ),
              const GroupButtonControls(),
            ],
          ),
        ],
      ),
    );
  }
}
