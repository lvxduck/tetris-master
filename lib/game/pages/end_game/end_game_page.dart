import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/core/widgets/tetris_button.dart';
import 'package:tetris_master/game/core/widgets/tetris_card.dart';
import 'package:tetris_master/game/pages/game/game.dart';

enum EndGameStatus {
  newRecord,
  failure,
  success,
}

class EndGamePage extends StatefulWidget {
  const EndGamePage({
    Key? key,
    required this.time,
    required this.status,
  }) : super(key: key);
  final int time;
  final EndGameStatus status;

  @override
  _EndGamePageState createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TetrisCard(
                color: GameColor.brown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.status == EndGameStatus.newRecord)
                      Text(
                        'NEW RECORD',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: GameColor.brown[100],
                        ),
                      ),
                    if (widget.status == EndGameStatus.failure)
                      Text(
                        'FAILURE',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: GameColor.brown[100],
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (widget.status != EndGameStatus.failure)
                      Text(
                        'TIME',
                        style: TextStyle(
                          fontSize: 16,
                          color: GameColor.brown[100],
                        ),
                      ),
                    Text(
                      Duration(milliseconds: widget.time)
                          .toString()
                          .substring(0, 9),
                      style: TextStyle(
                        fontSize: 32,
                        color: GameColor.brown[100],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TetrisButton(
                color: GameColor.orange,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const Game(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('RETRY'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TetrisButton(
                color: GameColor.brown,
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('BACK TO HOME'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
