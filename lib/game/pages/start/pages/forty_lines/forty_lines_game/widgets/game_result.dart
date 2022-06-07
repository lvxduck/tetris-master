import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/core/widgets/tetris_card.dart';

import '../forty_lines_game_state.dart';

class GameResult extends StatelessWidget {
  const GameResult({
    Key? key,
    required this.status,
    required this.time,
  }) : super(key: key);

  final int time;
  final EndGameStatus status;

  @override
  Widget build(BuildContext context) {
    return TetrisCard(
      color: GameColor.brown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status == EndGameStatus.newRecord)
            Text(
              'NEW RECORD',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: GameColor.brown[100],
              ),
            ),
          if (status == EndGameStatus.failure)
            Text(
              'FAILURE',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: GameColor.brown[100],
              ),
            ),
          const SizedBox(height: 8),
          if (status != EndGameStatus.failure)
            Text(
              'TIME',
              style: TextStyle(
                fontSize: 16,
                color: GameColor.brown[100],
              ),
            ),
          Text(
            Duration(milliseconds: time).toString().substring(0, 9),
            style: TextStyle(
              fontSize: 32,
              color: GameColor.brown[100],
            ),
          ),
        ],
      ),
    );
  }
}
